// scripts.js
document.addEventListener("DOMContentLoaded", function() {
  const replyButtons = document.querySelectorAll(".reply-btn");
  const popup = document.getElementById("reply-popup");
  const closeButton = document.querySelector(".close-btn");
  const replyForm = document.getElementById("reply-form");
  const responseText = document.getElementById("response-text");
  const messageIdInput = document.getElementById("message-id");

  replyButtons.forEach(button => {
    button.addEventListener("click", function() {
      const messageId = this.getAttribute("data-message-id");
      messageIdInput.value = messageId;
      popup.style.display = "block";
    });
  });

  closeButton.addEventListener("click", function() {
    popup.style.display = "none";
  });

  replyForm.addEventListener("submit", function(event) {
    event.preventDefault();
    const messageId = messageIdInput.value;
    const response = responseText.value;

    const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute("content");
    fetch(`/messages/${messageId}`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken
      },
      body: JSON.stringify({ message: { agent_response: response } })
    })
    .then(response => {
      if (response.ok) {
        console.log("Agent response successfully updated");
        popup.style.display = "none";
        responseText.value = "";
      } else {
        console.error("Failed to update agent response");
      }
    })
    .catch(error => {
      console.error("Error:", error);
    });
  });
});
