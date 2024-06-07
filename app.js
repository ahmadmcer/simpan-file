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
