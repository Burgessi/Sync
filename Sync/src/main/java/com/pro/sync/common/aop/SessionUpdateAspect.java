package com.pro.sync.common.aop;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.pro.sync.employee.vo.EmployeeVo;
import com.pro.sync.mypage.service.IMypageService;
import com.pro.sync.mypage.vo.AccountVo;

@Aspect
@Component
public class SessionUpdateAspect {

	@Autowired
    private HttpSession session;

    @Autowired
    private IMypageService service; // 필요한 서비스 주입

    @Before(value = "@annotation(UpdateSession)")
    public void updateSession() {
    	System.out.println("실행");
    	EmployeeVo loginDto = (EmployeeVo) session.getAttribute("loginDto");
        // 세션 갱신 로직 작성
        if (loginDto != null) {
            String emp_id = loginDto.getEmp_id();

            // 새로운 정보를 가져와 세션을 갱신
            EmployeeVo updatedInfoDto = service.getInfo(emp_id);
            AccountVo updatedAccDto = service.getAccountInfo(emp_id);
            
            // 세션에 갱신된 정보 저장
            session.setAttribute("infoDto", updatedInfoDto);
            session.setAttribute("accDto", updatedAccDto);
        }
    }
}