document.getElementById('uploadForm').addEventListener('submit', function(event) {
  event.preventDefault();

  const formData = new FormData();
  const fileInput = document.getElementById('fileInput');
  formData.append('file', fileInput.files[0]);

  fetch('/upload', {
      method: 'POST',
      body: formData
  })
  .then(response => response.json())
  .then(data => {
      document.getElementById('status').innerText = `File uploaded successfully: ${data.filename} (${data.size} bytes, ${data.mimetype})`;
  })
  .catch(error => {
      document.getElementById('status').innerText = 'Upload failed';
      console.error('Error:', error);
  });
});
