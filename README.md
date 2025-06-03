mysql -h centerbeam.proxy.rlwy.net -u root -p tNJLENlYvZgMGvDkWriXwFHfKKIhardD --port 58909 --protocol=TCP railway

CREATE TABLE student_fees ( id INT AUTO_INCREMENT PRIMARY KEY, student_name VARCHAR(100), description VARCHAR(100), amount VARCHAR(100), status VARCHAR(100), fee_date VARCHAR(100) );

CREATE TABLE remainder (
    id INT PRIMARY KEY AUTO_INCREMENT,
    task_name VARCHAR(255) NOT NULL,
    date VARCHAR(255) NOT NULL
);

CREATE TABLE student_invoice (
  id INT AUTO_INCREMENT PRIMARY KEY,
  payment_amount INT NOT NULL,
  tax INT NOT NULL,
  total INT NOT NULL,
  additional_notes TEXT,
  student_id INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
