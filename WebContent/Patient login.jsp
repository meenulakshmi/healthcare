<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>jQuery UI Datepicker - Default functionality</title>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script>
  $( function() {
    $( "#datepicker1" ).datepicker({ dateFormat: 'yy-mm-dd' });
    $( "#datepicker2" ).datepicker({ dateFormat: 'yy-mm-dd' });
  } );
  </script>
 </head>

<body background="healthcare.jpg">
<H2 align="center" > HEALTH CARE SYSTEM </H2> 
<br>

<form action="Patient_Detail_Display.jsp">
  
   <div class="container" align="center">
    <label><b>Patient id</b></label>
    <input type="text" placeholder="Enter Patient id" name="pid" required>    
    <p>Start Date: <input type="text" name="start_date" id="datepicker1" required></p>
    <p>End  Date: <input type="text"  name="end_date" id="datepicker2" required></p>
    
    <button type="submit">Submit</button>
  </div>
</form>

</body>
</html>