document.addEventListener('DOMContentLoaded', function () {
    loadFiles();

    document.getElementById('uploadForm').addEventListener('submit', function (event) {
        event.preventDefault();

        const formData = new FormData();
        const fileInput = document.getElementById('fileInput');
        formData.append('file', fileInput.files[0]);

        fetch('/upload', {
            method: 'POST',
            body: formData,
        })
            .then((response) => response.json())
            .then((data) => {
                document.getElementById('status').innerText =
                    `File uploaded successfully: ${data.filename} (${data.size} bytes, ${data.mimetype})`;
                loadFiles();
            })
            .catch((error) => {
                document.getElementById('status').innerText = 'Upload failed';
                console.error('Error:', error);
            });
    });

    document.getElementById('editForm').addEventListener('submit', function (event) {
        event.preventDefault();

        const formData = new FormData();
        const newFileName = document.getElementById('editFileName').value;
        const fileInput = document.getElementById('editFileInput');
        const fileId = document.getElementById('editForm').dataset.fileId;

        formData.append('newFileName', newFileName);
        if (fileInput.files.length > 0) {
            formData.append('file', fileInput.files[0]);
        }

        fetch(`/edit/${fileId}`, {
            method: 'PUT',
            body: formData,
        })
            .then((response) => response.json())
            .then((data) => {
                document.getElementById('editModal').classList.add('hidden');
                loadFiles();
            })
            .catch((error) => {
                console.error('Error:', error);
            });
    });

    document.getElementById('cancelEdit').addEventListener('click', function () {
        document.getElementById('editModal').classList.add('hidden');
    });
});

function loadFiles() {
    fetch('/files')
        .then((response) => response.json())
        .then((data) => {
            const fileList = document.getElementById('fileList');
            fileList.innerHTML = '';
            data.files.forEach((file) => {
                const fileItem = document.createElement('li');
                fileItem.classList.add('flex', 'justify-between', 'items-center', 'bg-gray-100', 'p-4', 'rounded-lg');
                fileItem.innerHTML = `
                <span>${file.originalname}</span>
                <div>
                    <button onclick="editFile('${file.filename}', '${file.originalname}')" class="px-4 py-2 bg-yellow-600 text-white rounded-lg hover:bg-yellow-700 mr-2">Edit</button>
                    <button onclick="deleteFile('${file.filename}')" class="px-4 py-2 bg-red-600 text-white rounded-lg hover:bg-red-700">Delete</button>
                </div>
            `;
                fileList.appendChild(fileItem);
            });
        })
        .catch((error) => {
            console.error('Error:', error);
        });
}

function editFile(filename, originalname) {
    document.getElementById('editFileName').value = originalname;
    document.getElementById('editForm').dataset.fileId = filename;
    document.getElementById('editModal').classList.remove('hidden');
}

function deleteFile(filename) {
    fetch(`/delete/${filename}`, {
        method: 'DELETE',
    })
        .then((response) => response.json())
        .then((data) => {
            loadFiles();
        })
        .catch((error) => {
            console.error('Error:', error);
        });
}
