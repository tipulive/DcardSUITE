<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>

</body>
<script>
   function addBusinessDays(startDate, daysToAdd) {
    let currentDate = new Date(startDate);
    let addedDays = 0;

    while (addedDays < daysToAdd) {
        currentDate.setDate(currentDate.getDate() + 1);

        // Check if the current day is a weekday (Monday to Friday)
        if (currentDate.getDay() !== 0 ) {//here 0 means exlc
            addedDays++;
        }
    }

    return currentDate;
}
checkRetention('2024-08-28','2024-08-16','Arrived');
function checkRetention(todaysD,startD,status){
    // Example usage

let startDate = new Date(startD);
let todaysDate = new Date(todaysD);
let resultDate = addBusinessDays(startDate, 4);

if(startD==="null" || status!=='Arrived'){
 return "...";
}
else if((todaysDate)>(resultDate))
{

   let differenceInTime = todaysDate.getTime() - resultDate.getTime();
    let differenceInDays = Math.ceil(differenceInTime / (1000 * 3600 * 24));
    console.log(`${differenceInDays} days`);

}else{

     return updateCountdown(todaysDate, resultDate);

}
}
function updateCountdown(todaysDate,resultDate) {
    let now = new Date();

             let timeRemaining = resultDate-todaysDate;
             //let timeRemaining = resultDate-now;

            if (timeRemaining > 0) {
                let days = Math.floor(timeRemaining / (1000 * 60 * 60 * 24));
                let hours = Math.floor((timeRemaining % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                let minutes = Math.floor((timeRemaining % (1000 * 60 * 60)) / (1000 * 60));
                let seconds = Math.floor((timeRemaining % (1000 * 60)) / 1000);

               console.log(`Left ${days} Days, ${hours} Hours,${minutes} Min`);


               //return "days";

            } else {

            }
    }
</script>
</html>
