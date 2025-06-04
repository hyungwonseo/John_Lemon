using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerController : MonoBehaviour
{
    public float moveSpeed = 1f;
    Rigidbody rb;
    Animator animator;

    Vector3 movementInput;
    string currentAnimation = "Idle";

    // Start is called before the first frame update
    void Start()
    {
        rb = GetComponent<Rigidbody>();
        animator = GetComponentInChildren<Animator>();
    }

    // Update is called once per frame
    void Update()
    {
        float moveX = Input.GetAxis("Horizontal");
        float moveZ = Input.GetAxis("Vertical");
        movementInput = new Vector3(moveX, 0, moveZ).normalized;

        UpdateAnimations();
    }

    private void FixedUpdate()
    {
        Vector3 movement = movementInput * moveSpeed;
        rb.MovePosition(rb.position + (movement * Time.fixedDeltaTime));

        // È¸Àü
        if (movement != Vector3.zero)
        {
            Quaternion targetRotation = Quaternion.LookRotation(movement);
            rb.rotation = Quaternion.Slerp(rb.rotation, targetRotation, Time.fixedDeltaTime * 10f);
        }
    }

    void UpdateAnimations()
    {
        if (movementInput.magnitude > 0)
        {
            PlayAnimation("Walk");
        }else
        {
            PlayAnimation("Idle");
        }
    }

    void PlayAnimation(string animationName)
    {
        if (currentAnimation == animationName) { return; }

        animator.Play(animationName);
        currentAnimation = animationName;
    }
}
