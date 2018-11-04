
#pragma once

#include <glm/glm.hpp>
#include "Device.h"

struct CameraBufferObject {
	CameraBufferObject()
	{
		orientationCullingEnabled = -1;
		frustumCullingEnabled = -1;
		distanceCullingEnabled = -1;
	}

  glm::mat4 viewMatrix;
  glm::mat4 projectionMatrix;
  float orientationCullingEnabled;
  float frustumCullingEnabled;
  float distanceCullingEnabled;
};

class Camera {
private:
    Device* device;
    
    CameraBufferObject cameraBufferObject;
    
    VkBuffer buffer;
    VkDeviceMemory bufferMemory;

    void* mappedData;


public:
    float r, theta, phi;
    Camera(Device* device, float aspectRatio);
    ~Camera();

    VkBuffer GetBuffer() const;

	void SetOrientationCullingEnabled(float mode);
	void SetFrustumCullingEnabled(float mode);
	void SetDistanceCullingEnabled(float mode);

	float IsOrientationCullingEnabled();
	float IsFrustumCullingEnabled();
	float IsDistanceCullingEnabled();
    
    void UpdateOrbit(float deltaX, float deltaY, float deltaZ);
};
