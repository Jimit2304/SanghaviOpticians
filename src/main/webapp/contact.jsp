<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Contact Us | Sanghavi Opticians</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
     <link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Custom CSS -->
<link rel="stylesheet" href="style.css">
<!-- Google Fonts -->
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f5f5f5;
        }

        .contact-box {
            background: white;
            padding: 40px;
            margin: 50px auto;
            border-radius: 10px;
            box-shadow: 0 0 25px rgba(0,0,0,0.05);
            max-width: 900px;
        }

        h2 {
            color: #1a237e;
            font-weight: 600;
            margin-bottom: 20px;
        }

        .info p {
            font-size: 1.1rem;
            margin: 10px 0;
            color: #333;
        }

        .map-link {
            margin-top: 20px;
            display: inline-block;
        }
    </style>
</head>
<body>
<jsp:include page="w.jsp" />
<div class="container contact-box">
    <h2>Contact Us</h2>
    <div class="info">
        <p><strong>Store Name:</strong> Sanghavi Opticians</p>
        <p><strong>Address:</strong> Opp. Akhbar Nagar BRTS Bus Stop, New Vadaj, Ahmedabad - 380013</p>
        <p><strong>Phone:</strong> +91-9998414438</p>
        <p><strong>Email:</strong> jimitsanghavi64@gmail.com</p>
        <p><strong>Working Hours:</strong> Mon - Sat: 10 AM to 8 PM, Sunday: Closed</p>
    </div>
    <h4 class="mt-4 mb-3">Find Us on Map</h4>
   <iframe 
    src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3670.2024346308015!2d72.55588087509133!3d23.089488779127328!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x395e84f546cc1581%3A0xe08c7eac8e296af1!2sSanghavi%20Opticians!5e0!3m2!1sen!2sin!4v1713523870441!5m2!1sen!2sin" 
    width="100%" 
    height="300" 
    style="border:0; border-radius:10px;" 
    allowfullscreen="" 
    loading="lazy" 
    referrerpolicy="no-referrer-when-downgrade">
</iframe>

    <a href="https://maps.app.goo.gl/6MosR1ujTSbqRENk8" target="_blank" class="btn btn-primary map-link">
        Open in Google Maps
    </a>
</div>
<jsp:include page="footer.jsp" />
</body>
</html>
