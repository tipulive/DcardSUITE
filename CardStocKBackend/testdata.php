<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Responsive 16-Row Grid</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      display: grid;
      grid-template-columns: repeat(5, 1fr); /* 4 columns in each row */
      grid-template-rows: repeat(16, 1fr); /* 16 rows */
      gap: 16px;
      justify-content: center;
      padding: 16px;
    }

    .grid-item {
      position: relative;
      width: 100%;
      //padding-bottom: 100%; /* Maintain a square aspect ratio for the container */
      overflow: hidden;
      border: 1px solid #ccc;
      display: flex;
      flex-direction: column;
      align-items: center;
    }

    .grid-item img {
      width: 100%;
      height: 50%; /* Adjust the height of the images */
      object-fit: cover;
    }

    .image-container {
      display: flex;
      width: 100%;
      height: 50%;
    }

    .image-container img {
      width: 70%;
      height: 100%;
      object-fit:cover;
    }

    .text-container {

      text-align: center;
    }

    .print-button {
      margin-top: 16px;
      padding: 8px;
      background-color: #4CAF50;
      color: #fff;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }
  </style>
</head>
<body>
  <!-- Repeat the following block for each grid item -->
  <div class="grid-item">
    <div class="image-container">
      <img src="image1.png" alt="Image 1">
      <img src="image2.png" alt="Image 2">
    </div>
    <div class="text-container">
      <p>Text for Image 1</p>
      <p>Text for Image 2</p>
    </div>
  </div>
  <div class="grid-item">
    <div class="image-container">
      <img src="image1.png" alt="Image 1">
      <img src="image2.png" alt="Image 2">
    </div>
    <div class="text-container">
      <p>Text for Image 1</p>
      <p>Text for Image 2</p>
    </div>
  </div>
  <div class="grid-item">
    <div class="image-container">
      <img src="image1.png" alt="Image 1">
      <img src="image2.png" alt="Image 2">
    </div>
    <div class="text-container">
      <p>Text for Image 1</p>
      <p>Text for Image 2</p>
    </div>
  </div>
  <div class="grid-item">
    <div class="image-container">
      <img src="image1.png" alt="Image 1">
      <img src="image2.png" alt="Image 2">
    </div>
    <div class="text-container">
      <p>Text for Image 1</p>
      <p>Text for Image 2</p>
    </div>
  </div>
  <div class="grid-item">
    <div class="image-container">
      <img src="image1.png" alt="Image 1">
      <img src="image2.png" alt="Image 2">
    </div>
    <div class="text-container">
      <p>Text for Image 1</p>
      <p>Text for Image 2</p>
    </div>
  </div>
  <div class="grid-item">
    <div class="image-container">
      <img src="image1.png" alt="Image 1">
      <img src="image2.png" alt="Image 2">
    </div>
    <div class="text-container">
      <p>Text for Image 1</p>
      <p>Text for Image 2</p>
    </div>
  </div>
  <div class="grid-item">
    <div class="image-container">
      <img src="image1.png" alt="Image 1">
      <img src="image2.png" alt="Image 2">
    </div>
    <div class="text-container">
      <p>Text for Image 1</p>
      <p>Text for Image 2</p>
    </div>
  </div>
  <div class="grid-item">
    <div class="image-container">
      <img src="image1.png" alt="Image 1">
      <img src="image2.png" alt="Image 2">
    </div>
    <div class="text-container">
      <p>Text for Image 1</p>
      <p>Text for Image 2</p>
    </div>
  </div>
  <div class="grid-item">
    <div class="image-container">
      <img src="image1.png" alt="Image 1">
      <img src="image2.png" alt="Image 2">
    </div>
    <div class="text-container">
      <p>Text for Image 1</p>
      <p>Text for Image 2</p>
    </div>
  </div>
  <div class="grid-item">
    <div class="image-container">
      <img src="image1.png" alt="Image 1">
      <img src="image2.png" alt="Image 2">
    </div>
    <div class="text-container">
      <p>Text for Image 1</p>
      <p>Text for Image 2</p>
    </div>
  </div>
  <div class="grid-item">
    <div class="image-container">
      <img src="image1.png" alt="Image 1">
      <img src="image2.png" alt="Image 2">
    </div>
    <div class="text-container">
      <p>Text for Image 1</p>
      <p>Text for Image 2</p>
    </div>
  </div>
  <div class="grid-item">
    <div class="image-container">
      <img src="image1.png" alt="Image 1">
      <img src="image2.png" alt="Image 2">
    </div>
    <div class="text-container">
      <p>Text for Image 1</p>
      <p>Text for Image 2</p>
    </div>
  </div>
  <div class="grid-item">
    <div class="image-container">
      <img src="image1.png" alt="Image 1">
      <img src="image2.png" alt="Image 2">
    </div>
    <div class="text-container">
      <p>Text for Image 1</p>
      <p>Text for Image 2</p>
    </div>
  </div>
  <div class="grid-item">
    <div class="image-container">
      <img src="image1.png" alt="Image 1">
      <img src="image2.png" alt="Image 2">
    </div>
    <div class="text-container">
      <p>Text for Image 1</p>
      <p>Text for Image 2</p>
    </div>
  </div>
  <div class="grid-item">
    <div class="image-container">
      <img src="image1.png" alt="Image 1">
      <img src="image2.png" alt="Image 2">
    </div>
    <div class="text-container">
      <p>Text for Image 1</p>
      <p>Text for Image 2</p>
    </div>
  </div>
  <div class="grid-item">
    <div class="image-container">
      <img src="image1.png" alt="Image 1">
      <img src="image2.png" alt="Image 2">
    </div>
    <div class="text-container">
      <p>Text for Image 1</p>
      <p>Text for Image 2</p>
    </div>
  </div>

  <!-- Repeat the above block for a total of 16 grid items -->

  <!-- Print button -->
  <button class="print-button" onclick="printGrid()">Print</button>

  <script>
    function printGrid() {
      window.print();
    }
  </script>
</body>
</html>
