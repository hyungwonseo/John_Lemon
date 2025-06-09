using UnityEngine;

public class EarthCameraController : MonoBehaviour
{
    public Transform target; // 지구 3D 모델의 Transform
    public float rotationSpeed = 1f; // 회전 속도 (더 낮게 설정)
    public float zoomSpeed = 2.0f; // 줌 속도
    public float minZoomDistance = 30.0f; // 최소 줌 거리
    public float maxZoomDistance = 50.0f; // 최대 줌 거리

    private float currentZoom = 40.0f; // 초기 줌 거리
    private Vector3 currentRotation; // 현재 회전 각도
    private Vector3 targetRotation;  // 목표 회전 각도
    public float smoothTime = 0.1f; // 회전 부드러움 설정 시간
    private Vector3 velocity = Vector3.zero; // 회전 감속을 위한 속도 변수

    void Start()
    {
        currentRotation = transform.eulerAngles; // 초기 회전 각도 설정
        targetRotation = currentRotation; // 목표 회전 각도 초기화
    }

    void Update()
    {
        HandleRotation();
        HandleZoom();
    }

    void HandleRotation()
    {
        
    }

    void HandleZoom()
    {
       
    }
}
