<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://cdn.datatables.net/2.1.5/css/dataTables.dataTables.css" />
  
<script src="https://cdn.datatables.net/2.1.5/js/dataTables.js"></script>

<table id="myTable" class="display">
    <thead>
        <tr>
            <th>Column 1</th>
            <th>Column 2</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Row 1 Data 1</td>
            <td>Row 1 Data 2</td>
        </tr>
        <tr>
            <td>멍미</td>
            <td>Row 2 Data 2</td>
        </tr>
    </tbody>
</table>

<script>
$(document).ready( function () {
    $('#myTable').DataTable();
} );
</script>