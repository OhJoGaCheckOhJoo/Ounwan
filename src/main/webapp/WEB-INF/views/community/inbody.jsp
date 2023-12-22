<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div><canvas class="inbodyGraph" id="inbodyScore" width="400px" height="120px"></canvas></div>
<div><canvas class="inbodyGraph" id="weight" width="400px" height="120px"></canvas></div>
<div><canvas class="inbodyGraph" id="skeletalMusclesMass" width="400px" height="120px"></canvas></div>
<div><canvas class="inbodyGraph" id="bodyWater" width="400px" height="120px"></canvas></div>
<div><canvas class="inbodyGraph" id="bmr" width="400px" height="120px"></canvas></div>
<div><canvas class="inbodyGraph" id="bmi" width="400px" height="120px"></canvas></div>

<script>
	var dateArray = '${updatedDate}'.slice(1,'${updatedDate}'.length - 1).split(',');
	
    var context = document
            .getElementById('inbodyScore')
            .getContext('2d');
        var myChart = new Chart(context, {
            type: 'line',
            data: {
                labels: dateArray,
                datasets: [
                    {
                        label: '인바디 점수',
                        data: ${inbodyScore},
                        borderColor: 'rgb(255, 0, 0)',
                        fill: false
                    }
                ]
            },
            options: {
                responsive: false
            }
        });

    var context = document
        .getElementById('weight')
        .getContext('2d');
    var myChart = new Chart(context, {
        type: 'line',
        data: {
            labels: dateArray,
            datasets: [
                {
                    label: '몸무게',
                    data: ${weight},
                    borderColor: 'rgb(0, 255, 0)',
                    fill: false
                }
            ]
        },
        options: {
            responsive: false
        }
    });
    
    var context = document
	    .getElementById('skeletalMusclesMass')
	    .getContext('2d');
	var myChart = new Chart(context, {
	    type: 'line',
	    data: {
	        labels: dateArray,
	        datasets: [
	            {
	                label: '골격근량',
	                data: ${skeletalMusclesMass},
	                borderColor: 'rgb(0, 0, 255)',
	                fill: false
	            }
	        ]
	    },
	    options: {
	        responsive: false
	    }
	}); 
	
	var context = document
	    .getElementById('bodyWater')
	    .getContext('2d');
	var myChart = new Chart(context, {
	    type: 'line',
	    data: {
	        labels: dateArray,
	        datasets: [
	            {
	                label: '체수분량',
	                data: ${bodyWater},
	                borderColor: 'rgb(124, 124, 0)',
	                fill: false
	            }
	        ]
	    },
	    options: {
	        responsive: false
	    }
	});
	
	var context = document
	    .getElementById('bmr')
	    .getContext('2d');
	var myChart = new Chart(context, {
	    type: 'line',
	    data: {
	        labels: dateArray,
	        datasets: [
	            {
	                label: 'BMR',
	                data: ${bmr},
	                borderColor: 'rgb(124, 0, 124)',
	                fill: false
	            }
	        ]
	    },
	    options: {
	        responsive: false
	    }
	});	
	
	var context = document
	    .getElementById('bmi')
	    .getContext('2d');
	var myChart = new Chart(context, {
	    type: 'line',
	    data: {
	        labels: dateArray,
	        datasets: [
	            {
	                label: 'BMI',
	                data: ${bmi},
	                borderColor: 'rgb(0, 124, 124)',
	                fill: false
	            }
	        ]
	    },
	    options: {
	        responsive: false
	    }
	});	
</script>