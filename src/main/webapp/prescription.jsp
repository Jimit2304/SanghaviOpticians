<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Prescription Form | Sanghavi Opticians</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="style.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #e67e22;
            --accent-color: #3498db;
            --background-color: #ecf0f1;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--background-color);
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        .navbar {
            background: linear-gradient(to right, var(--primary-color), var(--accent-color)) !important;
            padding: 1rem 0;
        }

        .navbar-brand {
            color: white !important;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .nav-link {
            color: white !important;
            font-weight: 500;
            margin: 0 1rem;
            transition: all 0.3s ease;
        }

        .nav-link:hover {
            color: var(--secondary-color) !important;
            transform: translateY(-2px);
        }

        .prescription-container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 30px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .prescription-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .prescription-header h2 {
            color: var(--primary-color);
            font-size: 2.5rem;
            font-weight: 600;
            margin-bottom: 15px;
        }

        .prescription-header p {
            color: #666;
            font-size: 1.1rem;
        }

        .prescription-form {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 30px;
            margin-bottom: 30px;
        }

        .form-section {
            background: #f8f9fa;
            padding: 25px;
            border-radius: 10px;
        }

        .form-section h3 {
            color: var(--primary-color);
            margin-bottom: 20px;
            font-size: 1.5rem;
        }

        .power-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr); /* Changed from 3 to 4 columns */
            gap: 15px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: var(--primary-color);
            font-weight: 500;
        }

        select, input[type="number"], input[type="text"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
        }

        .pd-section {
            margin-top: 20px;
        }

        .btn-submit, .btn-add-person, .btn-continue {
            background: var(--accent-color);
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 5px;
            font-size: 1.1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            width: 100%;
            margin-top: 20px;
        }

        .btn-add-person {
            background: var(--secondary-color);
            margin-bottom: 20px;
        }

        .btn-continue {
            background: var(--primary-color);
            margin-top: 10px;
        }

        .btn-submit:hover, .btn-add-person:hover, .btn-continue:hover {
            transform: translateY(-2px);
            opacity: 0.9;
        }

        .prescription-summary {
            margin-top: 40px;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 10px;
        }

        .prescription-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .prescription-table th,
        .prescription-table td {
            padding: 12px;
            text-align: center;
            border: 1px solid #ddd;
        }

        .prescription-table th {
            background: var(--primary-color);
            color: white;
        }

        .person-form {
            border: 2px solid #ddd;
            padding: 20px;
            margin-bottom: 30px;
            border-radius: 10px;
        }

        .person-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .remove-person {
            background: #dc3545;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 5px;
            cursor: pointer;
        }

        footer {
            background: linear-gradient(to right, var(--primary-color), var(--accent-color));
            color: white;
            padding: 20px 0;
            text-align: center;
            margin-top: 50px;
        }

        /* Added styles for multiple person handling */
        .person-list {
            margin-bottom: 30px;
        }

        .person-card {
            background: #fff;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 15px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .person-actions {
            display: flex;
            gap: 10px;
            margin-top: 10px;
        }

        .btn-edit-person,
        .btn-delete-person {
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .btn-edit-person {
            background: var(--accent-color);
            color: white;
        }

        .btn-delete-person {
            background: #dc3545;
            color: white;
        }

        /* Demo prescription styles */
        .demo-prescription {
            background: #e3f2fd;
            padding: 15px;
            border-radius: 8px;
            margin: 20px 0;
        }

        .demo-prescription h4 {
            color: var(--primary-color);
            margin-bottom: 10px;
        }

        .demo-values {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 10px;
            padding: 10px;
            background: white;
            border-radius: 5px;
        }

        .demo-value {
            text-align: center;
            padding: 8px;
            background: #f5f5f5;
            border-radius: 4px;
        }

        /* Demo summary styles */
        .demo-summary {
            background: #e3f2fd;
            padding: 15px;
            border-radius: 8px;
            margin: 20px 0;
        }

        .demo-summary h4 {
            color: var(--primary-color);
            margin-bottom: 15px;
        }

        .demo-summary-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 5px;
            overflow: hidden;
        }

        .demo-summary-table th,
        .demo-summary-table td {
            padding: 10px;
            text-align: center;
            border: 1px solid #ddd;
        }

        .demo-summary-table th {
            background: var(--primary-color);
            color: white;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand" href="#">Sanghavi Opticians</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="index.html">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="product.html">Shop</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="cart.html">Cart</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="dashboard.html">Account</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="prescription-container">
        <div class="prescription-header">
            <h2>Enter Prescriptions</h2>
            <p>Add prescriptions for multiple people</p>
        </div>

        <!-- Demo prescription values -->
        <div class="demo-prescription">
            <h4>Sample Prescription Values:</h4>
            <div class="demo-values">
                <div class="demo-value">
                    <strong>Sphere (SPH)</strong>
                    <p>+6.00</p>
                </div>
                <div class="demo-value">
                    <strong>Cylinder (CYL)</strong>
                    <p>+4.00</p>
                </div>
                <div class="demo-value">
                    <strong>Axis</strong>
                    <p>2</p>
                </div>
                <div class="demo-value">
                    <strong>Addition</strong>
                    <p>+2.50</p>
                </div>
            </div>
        </div>

        <!-- Demo prescription summary -->
        <div class="demo-summary">
            <h4>Sample Prescription Summary:</h4>
            <table class="demo-summary-table">
                <tr>
                    <th>Eye</th>
                    <th>SPH</th>
                    <th>CYL</th>
                    <th>AXIS</th>
                    <th>ADD</th>
                </tr>
                <tr>
                    <td>Right Eye (OD)</td>
                    <td>+2.00</td>
                    <td>-0.50</td>
                    <td>180</td>
                    <td>+1.75</td>
                </tr>
                <tr>
                    <td>Left Eye (OS)</td>
                    <td>+1.75</td>
                    <td>-0.75</td>
                    <td>175</td>
                    <td>+1.75</td>
                </tr>
                <tr>
                    <td colspan="4">Pupillary Distance (PD)</td>
                    <td>62 mm</td>
                </tr>
            </table>
        </div>

        <button type="button" class="btn-add-person" onclick="addPerson()">+ Add Another Person</button>

        <div id="prescriptionForms">
            <div class="person-form" id="person-1">
                <div class="person-header">
                    <h3>Person 1</h3>
                    <input type="text" placeholder="Enter name" class="person-name" required>
                </div>

                <div class="prescription-form">
                    <div class="form-section">
                        <h3>Right Eye (OD)</h3>
                        <div class="power-grid">
                            <div class="form-group">
                                <label>Sphere (SPH)</label>
                                <select class="rightSph" required>
                                    <option value="">Select SPH</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Cylinder</label>
                                <select class="rightCyl">
                                    <option value="">Select CYL</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Axis</label>
                                <select class="rightAxis">
                                    <option value="">Select Axis</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Addition</label>
                                <select class="rightAdd">
                                    <option value="">Select Addition</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="form-section">
                        <h3>Left Eye (OS)</h3>
                        <div class="power-grid">
                            <div class="form-group">
                                <label>Sphere (SPH)</label>
                                <select class="leftSph" required>
                                    <option value="">Select SPH</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Cylinder</label>
                                <select class="leftCyl">
                                    <option value="">Select CYL</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Axis</label>
                                <select class="leftAxis">
                                    <option value="">Select Axis</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Addition</label>
                                <select class="leftAdd">
                                    <option value="">Select Addition</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="pd-section">
                    <div class="form-group">
                        <label>Pupillary Distance (PD)</label>
                        <input type="number" class="pd" placeholder="Enter PD (in mm)" min="50" max="80">
                    </div>
                </div>
            </div>
        </div>


        <button type="button" class="btn-submit" onclick="generatePrescriptions()">Generate prescription</button>
        <button type="button" class="btn-continue" onclick="window.location.href='select.html'">Continue to Purchase</button>

        <div class="prescription-summary" id="prescriptionSummary">
            <h3>Prescription Summary</h3>
            <div class="person-list" id="personList"></div>
        </div>
    </div>

    <footer>
        <p>&copy; 2024 Sanghavi Opticians. All rights reserved.</p>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        let personCount = 1;
        let prescriptionData = [];

        function addPerson() {
            personCount++;
            const template = document.querySelector('.person-form').cloneNode(true);
            template.id = `person-${personCount}`;
            template.querySelector('h3').textContent = `Person ${personCount}`;
            
            // Add remove button for additional persons
            const removeBtn = document.createElement('button');
            removeBtn.className = 'remove-person';
            removeBtn.innerHTML = 'Remove';
            removeBtn.onclick = () => removePerson(template.id);
            template.querySelector('.person-header').appendChild(removeBtn);

            // Clear all inputs
            template.querySelectorAll('select').forEach(select => select.selectedIndex = 0);
            template.querySelector('.pd').value = '';
            template.querySelector('.person-name').value = '';

            document.getElementById('prescriptionForms').appendChild(template);
            populateOptions(template);
        }

        function removePerson(id) {
            document.getElementById(id).remove();
            prescriptionData = prescriptionData.filter(person => person.id !== id);
            updatePersonList();
        }

        function populateOptions(container = document) {
            // Populate axis options
            const axisSelects = container.querySelectorAll(".rightAxis, .leftAxis");
            axisSelects.forEach(select => {
                select.innerHTML = '<option value="">Select Axis</option>';
                for(let i = 1; i <= 180; i++) {
                    const option = document.createElement("option");
                    option.value = i;
                    option.text = i;
                    select.appendChild(option);
                }
            });

            // Populate sphere options
            const sphSelects = container.querySelectorAll(".rightSph, .leftSph");
            sphSelects.forEach(select => {
                select.innerHTML = '<option value="">Select SPH</option>';
                for(let i = 20; i >= -20; i -= 0.25) {
                    const option = document.createElement("option");
                    option.value = i.toFixed(2);
                    option.text = (i >= 0 ? "+" : "") + i.toFixed(2);
                    select.appendChild(option);
                }
            });

            // Populate cylinder options
            const cylSelects = container.querySelectorAll(".rightCyl, .leftCyl");
            cylSelects.forEach(select => {
                select.innerHTML = '<option value="">Select CYL</option>';
                for(let i = 6; i >= -6; i -= 0.25) {
                    const option = document.createElement("option");
                    option.value = i.toFixed(2);
                    option.text = (i >= 0 ? "+" : "") + i.toFixed(2);
                    select.appendChild(option);
                }
            });

            // Populate addition options
            const addSelects = container.querySelectorAll(".rightAdd, .leftAdd");
            addSelects.forEach(select => {
                select.innerHTML = '<option value="">Select Addition</option>';
                for(let i = -20; i <= 20; i += 0.25) {
                    const option = document.createElement("option");
                    option.value = i.toFixed(2);
                    option.text = (i >= 0 ? "+" : "") + i.toFixed(2);
                    select.appendChild(option);
                }
            });
        }

        function generatePrescriptions() {
            prescriptionData = [];
            document.querySelectorAll('.person-form').forEach(form => {
                const personData = {
                    id: form.id,
                    name: form.querySelector('.person-name').value || 'Unnamed',
                    rightEye: {
                        sph: form.querySelector('.rightSph').value,
                        cyl: form.querySelector('.rightCyl').value,
                        axis: form.querySelector('.rightAxis').value,
                        add: form.querySelector('.rightAdd').value
                    },
                    leftEye: {
                        sph: form.querySelector('.leftSph').value,
                        cyl: form.querySelector('.leftCyl').value,
                        axis: form.querySelector('.leftAxis').value,
                        add: form.querySelector('.leftAdd').value
                    },
                    pd: form.querySelector('.pd').value
                };
                prescriptionData.push(personData);
            });

            updatePersonList();
            displayPrescriptionSummary();
        }

        function updatePersonList() {
            const personList = document.getElementById('personList');
            personList.innerHTML = '';
            
            prescriptionData.forEach(person => {
                const personCard = document.createElement('div');
                personCard.className = 'person-card';
                personCard.innerHTML = `
                    <h4>${person.name}</h4>
                    <div class="person-actions">
                        <button class="btn-edit-person" onclick="editPerson('${person.id}')">
                            <i class="fas fa-edit"></i> Edit
                        </button>
                        <button class="btn-delete-person" onclick="deletePerson('${person.id}')">
                            <i class="fas fa-trash"></i> Delete
                        </button>
                    </div>
                `;
                personList.appendChild(personCard);
            });
        }

        function displayPrescriptionSummary() {
            const summary = document.getElementById('prescriptionSummary');
            summary.innerHTML = '<h3>Prescription Summary</h3>';

            prescriptionData.forEach(person => {
                const table = document.createElement('table');
                table.className = 'prescription-table';
                table.innerHTML = `
                    <h4 style="margin-top: 20px">${person.name}</h4>
                    <tr>
                        <th>Eye</th>
                        <th>SPH</th>
                        <th>CYL</th>
                        <th>AXIS</th>
                        <th>ADD</th>
                    </tr>
                    <tr>
                        <td>Right Eye (OD)</td>
                        <td>${person.rightEye.sph}</td>
                        <td>${person.rightEye.cyl}</td>
                        <td>${person.rightEye.axis}</td>
                        <td>${person.rightEye.add}</td>
                    </tr>
                    <tr>
                        <td>Left Eye (OS)</td>
                        <td>${person.leftEye.sph}</td>
                        <td>${person.leftEye.cyl}</td>
                        <td>${person.leftEye.axis}</td>
                        <td>${person.leftEye.add}</td>
                    </tr>
                    <tr>
                        <td colspan="4">Pupillary Distance (PD)</td>
                        <td>${person.pd} mm</td>
                    </tr>
                `;
                summary.appendChild(table);
            });
        }

        function editPerson(id) {
            const personForm = document.getElementById(id);
            personForm.scrollIntoView({ behavior: 'smooth' });
        }

        function deletePerson(id) {
            removePerson(id);
        }

        // Initialize options for the first person
        populateOptions();
    </script>
</body>
</html>
