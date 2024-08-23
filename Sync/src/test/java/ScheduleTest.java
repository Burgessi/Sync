import static org.junit.Assert.assertNotEquals;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.pro.sync.plan.service.IScheduleService;
import com.pro.sync.plan.vo.ScheduleVo;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class ScheduleTest {

	@Autowired
	private IScheduleService service;
		
	@Test
	public void test() {
	 List<ScheduleVo> lists = service.selectScd();
	 assertNotEquals("lists", lists);
	}

}
