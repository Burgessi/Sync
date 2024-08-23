package com.sync.test;

import static org.junit.Assert.*;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.pro.sync.employee.dao.EmployeeDao;
import com.pro.sync.employee.vo.EmployeeVo;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "file:src/main/webapp/WEB-INF/spring/appServlet/**/*.xml")
public class Employee_JUnitTest {

	@Autowired
	private EmployeeDao dao;
	
	@Test
	public void test() {
		List<EmployeeVo> list = dao.getAllEmployee();
		assertNotEquals(0, list.size());
	}

}
