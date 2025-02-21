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
    const ext = path.extname(file.originalname);
    const baseName = path.basename(file.originalname, ext); 
    cb(null, `${baseName}${ext}`); 
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
  const imageUrl = `http://192.168.170.54:8080/uploads/${req.file.filename}`;
  
  const query = "INSERT INTO services_images (service_id, image_url) VALUES (?, ?)";
  con.query(query, [serviceId, imageUrl], (err, result) => {
    if (err) {
      console.error('Database Error:', err);
      return res.status(500).json({ error: 'Database query failed' });
    }
    return res.json({ success: true, image_url: imageUrl });
  });
});



app.post('/edit_image', upload.single('image'), (req, res) => {
  if (!req.file) {
    return res.status(400).json({ error: 'No file uploaded' });
  }
  const serviceId = req.body.serviceId || null;
  const imageUrl = `http://192.168.170.54:8080/uploads/${req.file.filename}`;
  const query = "UPDATE services_images SET image_url = ? WHERE service_id = ?";
  con.query(query, [serviceId, imageUrl], (err, result) => {
    if (err) {
      console.error('Database Error:', err);
      return res.status(500).json({ error: 'Database query failed' });
    }
    return res.json({ success: true, image_url: imageUrl });
  });
});

app.post('/upload_profile', upload.single('image'), (req, res) => {
  if (!req.file) {
    return res.status(400).json({ error: 'No file uploaded' });
  }
  const userId = req.body.userId || null;
  const user_profile = `http://192.168.170.54:8080/uploads/${req.file.filename}`;
  
  const query = "INSERT INTO user_profile (user_id, user_profile) VALUES (?, ?)";
  con.query(query, [userId, user_profile], (err, result) => {
    if (err) {
      console.error('Database Error:', err);
      return res.status(500).json({ error: 'Database query failed' });
    }
    return res.json({ success: true, user_profile: user_profile });
  });
});

app.post('/edit_profile', upload.single('image'), (req, res) => {
  if (!req.file) {
    return res.status(400).json({ error: 'No file uploaded' });
  }
  const userId = req.body.userId || null;
  const user_profile = `http://192.168.170.54:8080/uploads/${req.file.filename}`;
  const query = "UPDATE user_profile SET user_profile = ? WHERE user_id = ?";
  con.query(query, [userId, user_profile], (err, result) => {
    if (err) {
      console.error('Database Error:', err);
      return res.status(500).json({ error: 'Database query failed' });
    }
    return res.json({ success: true, user_profile: user_profile });
  });
});
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

app.listen(8080, () => {
  console.log('Server is running on port 8080');
});
