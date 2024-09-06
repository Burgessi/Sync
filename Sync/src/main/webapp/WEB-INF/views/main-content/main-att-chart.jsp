<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
.chart-area{
/*  	display: flex;  */
/* 	justify-content: space-between; */
	width: 90%; 
	height: 50%;
	align-content: center;
}
table{
	width: 100%;
	table-layout: fixed;
}

  td {
    width: 20%; /* 각 셀의 너비를 50%로 설정 */
    text-align: center; /* 차트를 중앙에 배치 */
    padding: 10px; /* 셀 안쪽 여백을 추가 */
  }
/*   #weekChart, #monthChart { */
/*     width: 300px; */
/*     height: 300px; */
/*   } */
 .chart-canvas {
    width: 450px !important;
/*     height: 300px !important; */
  }
  canvas{
  	max-height: 320px;
  }
tbody {
    text-align: center;
    vertical-align: middle;
}

.chart-canvas {
    display: block;
    margin: 0 auto; /* 차트를 수평으로 가운데 정렬 */
    max-height: 320px;
}

</style>

<div>
	<table>
		<thead>
			<tr>
				<td style="font-size: 1.1em; color:#25396f;"><strong>주간 근무 현황</strong></td>
				<td style="font-size: 1.1em; color:#25396f;"><strong>월간 근무 현황</strong></td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><canvas id="weekChart" class="chart-canvas" style="text-align: center;"></canvas></td>
      			<td><canvas id="monthChart" class="chart-canvas"></canvas></td>
			</tr>
		</tbody>
	</table>
	
	
</div>


<script>
  $(document).ready(function() {
	  const emp_id = '${loginDto.emp_id}';
    // 주간 차트 데이터 요청
    $.ajax({
      url: './getWeeklyWorkDuration.do',
      method: 'GET',
      data: { emp_id: emp_id },
      dataType: 'json',
      success: function(data) {
        const totalHoursPerWeek = 40 * 3600;
        function timeStringToSeconds(timeString) {
          const parts = timeString.split(':');
          const hours = parseInt(parts[0], 10) * 3600;
          const minutes = parseInt(parts[1], 10) * 60;
          const seconds = parseInt(parts[2], 10);
          return hours + minutes + seconds;
        }

        const workedSeconds = timeStringToSeconds(data.weekDurationSeconds);
        const remainingSeconds = totalHoursPerWeek - workedSeconds;
        const workedHours = workedSeconds / 3600;
        const extraHours = Math.max(-remainingSeconds / 3600, 0);
        const remainingHours = Math.max(remainingSeconds / 3600, 0);

        const ctx = $('#weekChart');
        new Chart(ctx, {
          type: 'bar',
          data: {
            labels: ['Worked Hours', 'Extra Hours'],
            datasets: [{
              type: 'bar',
              label: 'Worked Hours',
              data: [workedHours, extraHours],
              backgroundColor: ['#36A2EB', '#FFCE56'],
              zIndex: 1 // 바 차트의 zIndex 설정
            },
            {
              type: 'line',
              label: 'Total Hours per Week',
              data: Array(2).fill(totalHoursPerWeek / 3600),
              borderColor: '#FF6384',
              backgroundColor: 'rgba(255, 99, 132, 0.2)',
              fill: false,
              borderWidth: 2,
              tension: 0.1,
              zIndex: 2 // 라인 차트의 zIndex 설정 (바 차트보다 위)
            }]
          },
          options: {
            responsive: true,
            plugins: {
              legend: {
                position: 'top',
              },
              tooltip: {
                callbacks: {
                  label: function(tooltipItem) {
                    const hours = tooltipItem.raw;
                    return hours.toFixed(2) + ' hours';
                  }
                }
              }
            },
            scales: {
              x: {
                stacked: true
              },
              y: {
                stacked: true
              }
            }
          }
        });
      },
      error: function(err) {
        console.error('Error fetching data:', err);
      }
    });

    // 월간 차트 데이터 요청
    $.ajax({
      url: './getMonthlyWorkDuration.do',
      method: 'GET',
      data: { emp_id: emp_id},
      dataType: 'json',
      success: function(data) {
        const totalHoursPerMonth = 4 * 40 * 3600;
        function timeStringToSeconds(timeString) {
          const parts = timeString.split(':');
          const hours = parseInt(parts[0], 10) * 3600;
          const minutes = parseInt(parts[1], 10) * 60;
          const seconds = parseInt(parts[2], 10);
          return hours + minutes + seconds;
        }

        const workedSeconds = timeStringToSeconds(data.monthDurationSeconds);
        const remainingSeconds = totalHoursPerMonth - workedSeconds;
        const workedHours = workedSeconds / 3600;
        const extraHours = Math.max(-remainingSeconds / 3600, 0);
        const remainingHours = Math.max(remainingSeconds / 3600, 0);

        const ctx = $('#monthChart');
        new Chart(ctx, {
          type: 'bar',
          data: {
            labels: ['Worked Hours', 'Extra Hours'],
            datasets: [{
              type: 'bar',
              label: 'Worked Hours',
              data: [workedHours, extraHours],
              backgroundColor: ['#36A2EB', '#FFCE56'],
              zIndex: 1 // 바 차트의 zIndex 설정
            },
            {
              type: 'line',
              label: 'Total Hours per Month',
              data: Array(2).fill(totalHoursPerMonth / 3600),
              borderColor: '#FF6384',
              backgroundColor: 'rgba(255, 99, 132, 0.2)',
              fill: false,
              borderWidth: 2,
              tension: 0.1,
              zIndex: 2 // 라인 차트의 zIndex 설정 (바 차트보다 위)
            }]
          },
          options: {
            responsive: true,
            plugins: {
              legend: {
                position: 'top',
              },
              tooltip: {
                callbacks: {
                  label: function(tooltipItem) {
                    const hours = tooltipItem.raw;
                    return hours.toFixed(2) + ' hours';
                  }
                }
              }
            },
            scales: {
              x: {
                stacked: true
              },
              y: {
                stacked: true
              }
            }
          }
        });
      },
      error: function(err) {
        console.error('Error fetching data:', err);
      }
    });
  });
</script>
