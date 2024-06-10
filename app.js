const express = require('express');
const multer = require('multer');
const fs = require('fs');
const path = require('path');
const app = express();
const PORT = 3300;

const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, 'uploads/');
    },
    filename: function (req, file, cb) {
        cb(null, file.fieldname + '-' + Date.now() + path.extname(file.originalname));
    },
});

const upload = multer({storage: storage});

app.use(express.static('public'));
app.use(express.json());

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

app.get('/files', (req, res) => {
    fs.readdir('uploads', (err, files) => {
        if (err) {
            res.status(500).send('Unable to retrieve files');
            return;
        }
        const fileDetails = files.map((filename) => {
            const filePath = path.join('uploads', filename);
            const stat = fs.statSync(filePath);
            return {
                filename: filename,
                originalname: filename.split('-')[1], // Extract original name assuming format: file-<timestamp>.<ext>
                size: stat.size,
                mimetype: 'application/octet-stream', // Placeholder, ideally we would store the MIME type
            };
        });
        res.json({files: fileDetails});
    });
});

app.put('/edit/:filename', upload.single('file'), (req, res) => {
    const oldFilename = req.params.filename;
    const newFileName = req.body.newFileName;
    const newFilePath = `uploads/file-${Date.now()}${path.extname(newFileName)}`;
    const oldFilePath = path.join('uploads', oldFilename);

    if (req.file) {
        fs.unlink(oldFilePath, (err) => {
            if (err) {
                res.status(500).send('Unable to delete old file');
                return;
            }
            fs.rename(req.file.path, newFilePath, (err) => {
                if (err) {
                    res.status(500).send('Unable to rename new file');
                    return;
                }
                res.json({message: 'File updated successfully'});
            });
        });
    } else {
        fs.rename(oldFilePath, newFilePath, (err) => {
            if (err) {
                res.status(500).send('Unable to rename file');
                return;
            }
            res.json({message: 'File renamed successfully'});
        });
    }
});

app.delete('/delete/:filename', (req, res) => {
    const filename = req.params.filename;
    const filePath = path.join('uploads', filename);

    fs.unlink(filePath, (err) => {
        if (err) {
            res.status(500).send('Unable to delete file');
            return;
        }
        res.json({message: 'File deleted successfully'});
    });
});

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
