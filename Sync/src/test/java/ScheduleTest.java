import static org.junit.Assert.assertEquals;

import java.time.LocalDateTime;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.pro.sync.reservations.service.IReservationService;
import com.pro.sync.reservations.vo.ReservationsVo;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class ScheduleTest {

	@Autowired
	private IReservationService service;
		
	@Test
	public void test() {
	 
	     // 주어진 기간 설정
        LocalDateTime start = LocalDateTime.of(2024, 9, 3, 8, 0);
        LocalDateTime end = LocalDateTime.of(2024, 9, 3, 11, 0);
        
        // 데이터 객체 생성
        ReservationsVo vo = new ReservationsVo();
        vo.setRev_start(start);
        vo.setRev_end(end);
        vo.setFcl_id(123); // 예시로 FCL_ID 값을 설정

        // 메서드 호출 및 결과 확인
        int overlap = service.selectOverlap(vo);
        System.out.println("Overlap: " + overlap);

        // 실제 테스트에서는 assertion을 사용하여 결과를 확인합니다.
        assertEquals(1, overlap); // 예를 들어, 결과가 1일 것으로 예상
	}
}
