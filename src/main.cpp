#include <vulkan/vulkan.h>
#include "Instance.h"
#include "Window.h"
#include "Renderer.h"
#include "Camera.h"
#include "Scene.h"
#include "Image.h"
#include <sstream>

Device* device;
SwapChain* swapChain;
Renderer* renderer;
Camera* camera;
bool record = false;
float record_tick = 1;
float record_totalFPS = 0;
int camera_distance_mode = 0;
const int camera_distance_mode_count = 3;
const int tick_max = 1000;

namespace {
    void resizeCallback(GLFWwindow* window, int width, int height) {
        if (width == 0 || height == 0) return;

        vkDeviceWaitIdle(device->GetVkDevice());
        swapChain->Recreate();
        renderer->RecreateFrameResources();
    }

    bool leftMouseDown = false;
    bool rightMouseDown = false;
    double previousX = 0.0;
    double previousY = 0.0;

    void mouseDownCallback(GLFWwindow* window, int button, int action, int mods) {
        if (button == GLFW_MOUSE_BUTTON_LEFT) {
            if (action == GLFW_PRESS) {
                leftMouseDown = true;
                glfwGetCursorPos(window, &previousX, &previousY);
            }
            else if (action == GLFW_RELEASE) {
                leftMouseDown = false;
            }
        } else if (button == GLFW_MOUSE_BUTTON_RIGHT) {
            if (action == GLFW_PRESS) {
                rightMouseDown = true;
                glfwGetCursorPos(window, &previousX, &previousY);
            }
            else if (action == GLFW_RELEASE) {
                rightMouseDown = false;
            }
        }
    }

    void mouseMoveCallback(GLFWwindow* window, double xPosition, double yPosition) {
        if (leftMouseDown) {
            double sensitivity = 0.5;
            float deltaX = static_cast<float>((previousX - xPosition) * sensitivity);
            float deltaY = static_cast<float>((previousY - yPosition) * sensitivity);

            camera->UpdateOrbit(deltaX, deltaY, 0.0f);
			printf("r, theta, phi: %f,%f,%f\n", camera->r, camera->theta, camera->phi);

            previousX = xPosition;
            previousY = yPosition;
        } else if (rightMouseDown) {
            double deltaZ = static_cast<float>((previousY - yPosition) * 0.05);

            camera->UpdateOrbit(0.0f, 0.0f, deltaZ);
			printf("r, theta, phi: %f,%f,%f\n", camera->r, camera->theta, camera->phi);

            previousY = yPosition;
        }
    }

	void keyCallback(GLFWwindow* window, int key, int scancode, int action, int mods)
	{
		if (key == GLFW_KEY_1 && action == GLFW_PRESS)
		{
			camera->SetOrientationCullingEnabled(-1.f*camera->IsOrientationCullingEnabled());
			printf("orientation culling: %f\n", camera->IsOrientationCullingEnabled());
		}
		if (key == GLFW_KEY_2 && action == GLFW_PRESS)
		{
			camera->SetFrustumCullingEnabled(-1.f*camera->IsFrustumCullingEnabled());
			printf("frustum culling: %f\n", camera->IsFrustumCullingEnabled());
		}
		if (key == GLFW_KEY_3 && action == GLFW_PRESS)
		{
			camera->SetDistanceCullingEnabled(-1.f*camera->IsDistanceCullingEnabled());
			printf("distance culling: %f\n", camera->IsDistanceCullingEnabled());
		}
		if (key == GLFW_KEY_R && action == GLFW_PRESS)
		{
			record = !record;
			printf("record: %d\n", record);
			if (record)
			{
				record_tick = 0;
				record_totalFPS = 0;
			}
		}
		if (key == GLFW_KEY_C && action == GLFW_PRESS)
		{
			camera_distance_mode = (camera_distance_mode + 1) % camera_distance_mode_count;
			if(camera_distance_mode == 0)
				camera->r = 50;
			if (camera_distance_mode == 1)
				camera->r = 20;
			if (camera_distance_mode == 2)
				camera->r = 5;
			camera->theta = 0;
			camera->phi = -34;
			camera->UpdateOrbit(0.0f, 0.0f, 0.0f);
			printf("r, theta, phi: %f,%f,%f\n", camera->r, camera->theta, camera->phi);
		}
	}
}

int main() {
    static constexpr char* applicationName = "Vulkan Grass Rendering";
    InitializeWindow(640, 480, applicationName);

    unsigned int glfwExtensionCount = 0;
    const char** glfwExtensions = glfwGetRequiredInstanceExtensions(&glfwExtensionCount);

    Instance* instance = new Instance(applicationName, glfwExtensionCount, glfwExtensions);

    VkSurfaceKHR surface;
    if (glfwCreateWindowSurface(instance->GetVkInstance(), GetGLFWWindow(), nullptr, &surface) != VK_SUCCESS) {
        throw std::runtime_error("Failed to create window surface");
    }

    instance->PickPhysicalDevice({ VK_KHR_SWAPCHAIN_EXTENSION_NAME }, QueueFlagBit::GraphicsBit | QueueFlagBit::TransferBit | QueueFlagBit::ComputeBit | QueueFlagBit::PresentBit, surface);

    VkPhysicalDeviceFeatures deviceFeatures = {};
    deviceFeatures.tessellationShader = VK_TRUE;
    deviceFeatures.fillModeNonSolid = VK_TRUE;
    deviceFeatures.samplerAnisotropy = VK_TRUE;

    device = instance->CreateDevice(QueueFlagBit::GraphicsBit | QueueFlagBit::TransferBit | QueueFlagBit::ComputeBit | QueueFlagBit::PresentBit, deviceFeatures);

    swapChain = device->CreateSwapChain(surface, 5);

    camera = new Camera(device, 640.f / 480.f);

    VkCommandPoolCreateInfo transferPoolInfo = {};
    transferPoolInfo.sType = VK_STRUCTURE_TYPE_COMMAND_POOL_CREATE_INFO;
    transferPoolInfo.queueFamilyIndex = device->GetInstance()->GetQueueFamilyIndices()[QueueFlags::Transfer];
    transferPoolInfo.flags = 0;

    VkCommandPool transferCommandPool;
    if (vkCreateCommandPool(device->GetVkDevice(), &transferPoolInfo, nullptr, &transferCommandPool) != VK_SUCCESS) {
        throw std::runtime_error("Failed to create command pool");
    }

    VkImage grassImage;
    VkDeviceMemory grassImageMemory;
    Image::FromFile(device,
        transferCommandPool,
        "images/grass.jpg",
        VK_FORMAT_R8G8B8A8_UNORM,
        VK_IMAGE_TILING_OPTIMAL,
        VK_IMAGE_USAGE_SAMPLED_BIT,
        VK_IMAGE_LAYOUT_SHADER_READ_ONLY_OPTIMAL,
        VK_MEMORY_PROPERTY_DEVICE_LOCAL_BIT,
        grassImage,
        grassImageMemory
    );

    float planeDim = 15.f;
    float halfWidth = planeDim * 0.5f;
    Model* plane = new Model(device, transferCommandPool,
        {
            { { -halfWidth, 0.0f, halfWidth }, { 1.0f, 0.0f, 0.0f },{ 1.0f, 0.0f } },
            { { halfWidth, 0.0f, halfWidth }, { 0.0f, 1.0f, 0.0f },{ 0.0f, 0.0f } },
            { { halfWidth, 0.0f, -halfWidth }, { 0.0f, 0.0f, 1.0f },{ 0.0f, 1.0f } },
            { { -halfWidth, 0.0f, -halfWidth }, { 1.0f, 1.0f, 1.0f },{ 1.0f, 1.0f } }
        },
        { 0, 1, 2, 2, 3, 0 }
    );
    plane->SetTexture(grassImage);
    
    Blades* blades = new Blades(device, transferCommandPool, planeDim);

    vkDestroyCommandPool(device->GetVkDevice(), transferCommandPool, nullptr);

    Scene* scene = new Scene(device);
    scene->AddModel(plane);
    scene->AddBlades(blades);

    renderer = new Renderer(device, swapChain, scene, camera);

    glfwSetWindowSizeCallback(GetGLFWWindow(), resizeCallback);
    glfwSetMouseButtonCallback(GetGLFWWindow(), mouseDownCallback);
    glfwSetCursorPosCallback(GetGLFWWindow(), mouseMoveCallback);
	glfwSetKeyCallback(GetGLFWWindow(), keyCallback);

	std::stringstream ss;
	int tick = 0;
	float totalFPS = 0;
    while (!ShouldQuit()) {
        glfwPollEvents();
        scene->UpdateTime();

		high_resolution_clock::time_point t1 = high_resolution_clock::now();
        renderer->Frame();
		high_resolution_clock::time_point t2 = high_resolution_clock::now();

		duration<float> deltaTime = duration_cast<duration<float>>(t2 - t1);
		float FPS = 1.0 / deltaTime.count();//in second
		totalFPS += FPS;
		tick++;

		if (tick == tick_max)
		{
			totalFPS = totalFPS / tick_max;
			ss << totalFPS << " fps : record";

			if (record)
			{
				record_totalFPS += totalFPS;
				record_tick++;
				ss << "ing";
			}
			else
			{
				float show_record_totalFPS = record_totalFPS / record_tick;
				ss << "ed " << show_record_totalFPS << " fps";
			}

			if (record_tick == 10)
			{
				record = false;
			}

			glfwSetWindowTitle(GetGLFWWindow(), ss.str().c_str());
			ss.clear();
			ss.str("");
			tick = 0;
			totalFPS = 0;
		}
		
    }

    vkDeviceWaitIdle(device->GetVkDevice());

    vkDestroyImage(device->GetVkDevice(), grassImage, nullptr);
    vkFreeMemory(device->GetVkDevice(), grassImageMemory, nullptr);

    delete scene;
    delete plane;
    delete blades;
    delete camera;
    delete renderer;
    delete swapChain;
    delete device;
    delete instance;
    DestroyWindow();
    return 0;
}
