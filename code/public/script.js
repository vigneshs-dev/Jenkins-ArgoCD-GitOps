async function fetchMessage() {
    try {
      const response = await fetch('/hello');
      const message = await response.text();
      document.getElementById('message').textContent = message;
    } catch (error) {
      console.error('Error fetching message:', error);
      document.getElementById('message').textContent = 'Failed to load message.';
    }
  }
  