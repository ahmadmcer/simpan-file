# Project Upload File dengan Node.js dan Multer

Project ini adalah contoh aplikasi upload file menggunakan Node.js dan Multer. Aplikasi ini terdiri dari frontend (HTML, CSS, JavaScript) dan backend (Node.js). File yang di-upload akan disimpan di folder `uploads/` pada server.

## 1. Inisialisasi Project

Inisialisasi proyek Node.js dan install dependencies:
```sh
npm init -y
npm install express multer tailwindcss
```

## 2. Struktur Folder

Gambaran struktur folder proyek:

```plaintext
project-folder/
|-- uploads/            # Folder untuk menyimpan file yang di-upload
|-- public/
|   |-- index.html      # File HTML
|   |-- script.js       # File JavaScript
|   `-- style.css       # File CSS (Tailwind CSS)
|-- src/
|   `-- tailwind.css    # File CSS Tailwind
|-- app.js              # File server Node.js
|-- package.json        # File konfigurasi npm
`-- tailwind.config.js  # File konfigurasi Tailwind CSS
```

## 3. Konfigurasi Tailwind CSS

Buat file `tailwind.config.js` dengan perintah:
```sh
npx tailwindcss init
```

Kemudian, buat file `src/tailwind.css` dan tambahkan kode berikut:
```css
@tailwind base;
@tailwind components;
@tailwind utilities;
```

Tambahkan script untuk build Tailwind CSS pada `package.json`:
```json
"scripts": {
    "tw-build": "tailwindcss build src/tailwind.css -o public/style.css --watch"
}
```

Build Tailwind CSS dengan perintah:
```sh
npm run tw-build
```

## 4. HTML (index.html)

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>File Upload Form</title>
    <link href="style.css" rel="stylesheet">
</head>
<body class="flex items-center justify-center h-screen bg-gray-100">
    <div class="bg-white p-8 rounded-lg shadow-lg text-center">
        <h1 class="text-2xl font-bold mb-4">Upload File</h1>
        <form id="uploadForm" enctype="multipart/form-data" class="space-y-4">
            <input type="file" id="fileInput" name="file" class="block w-full text-sm text-gray-900 border border-gray-300 rounded-lg cursor-pointer focus:outline-none" required>
            <button type="submit" class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700">Upload</button>
        </form>
        <p id="status" class="mt-4 text-sm text-gray-600"></p>
    </div>
    <script src="script.js"></script>
</body>
</html>
```

## 5. JavaScript (script.js)

```javascript
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
```

## 6. Backend (app.js)

```javascript
const express = require('express');
const multer = require('multer');
const path = require('path');
const app = express();
const PORT = 3000;

const storage = multer.diskStorage({
    destination: function(req, file, cb) {
        cb(null, 'uploads/');
    },
    filename: function(req, file, cb) {
        cb(null, file.fieldname + '-' + Date.now() + path.extname(file.originalname));
    }
});

const upload = multer({ storage: storage });

app.use(express.static('public'));

app.post('/upload', upload.single('file'), (req, res) => {
    const file = req.file;
    if (!file) {
        res.status(400).send('No file uploaded.');
        return;
    }
    res.json({
        filename: file.filename,
        originalname: file.originalname,
        size: file.size,
        mimetype: file.mimetype,
    });
});

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
```

## 7. Menjalankan Aplikasi

Jalankan server dengan perintah:
```sh
node app.js
```

Akses aplikasi di browser pada `http://localhost:3000`.