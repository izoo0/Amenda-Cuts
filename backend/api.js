const express = require('express');
const mysql = require('mysql');
const multer = require('multer');
const cors = require('cors');
const path = require('path');

// Multer storage configuration
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'uploads/'); // Specify the directory to save files
  },
  filename: function (req, file, cb) {
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
    const ext = path.extname(file.originalname); // Get the file extension
    const baseName = path.basename(file.originalname, ext); // Get the original file name without extension
    cb(null, `${baseName}-${uniqueSuffix}${ext}`); // Save with the new unique name
  }
});

// Initialize multer with the storage configuration
const upload = multer({ storage: storage });

const con = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'amenda_cuts',
});

const app = express();

app.use(cors());

app.post('/upload_image', upload.single('image'), (req, res) => {
  if (!req.file) {
    return res.status(400).json({ error: 'No file uploaded' });
  }
  const serviceId = req.body.serviceId || null;
  const imageUrl = `http://192.168.33.213:8080/uploads/${req.file.filename}`;
  
  const query = "INSERT INTO services_images (service_id, image_url) VALUES (?, ?)";
  con.query(query, [serviceId, imageUrl], (err, result) => {
    if (err) {
      console.error('Database Error:', err);
      return res.status(500).json({ error: 'Database query failed' });
    }
    return res.json({ success: true, image_url: imageUrl });
  });
});

// Static route to serve images from the 'uploads' directory
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

app.listen(8080, () => {
  console.log('Server is running on port 8080');
});
