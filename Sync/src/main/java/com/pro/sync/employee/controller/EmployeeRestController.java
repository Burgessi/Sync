package com.pro.sync.employee.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.pro.sync.employee.service.EmployeeService;
import com.pro.sync.employee.vo.EmployeeVo;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class EmployeeRestController {

	@Autowired
    private EmployeeService employeeService;

	  @GetMapping("/employeeDetail.do")
	    public EmployeeVo getEmployeeDetail(@RequestParam("emp_id") String empId) {
	        log.info("Received request for employee ID: {}", empId);
	        EmployeeVo employee = employeeService.employeeSelectDetail(empId);
	        
	        return employee;
	    }
}
