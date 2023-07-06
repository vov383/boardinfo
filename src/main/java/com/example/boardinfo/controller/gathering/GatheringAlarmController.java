package com.example.boardinfo.controller.gathering;

import com.example.boardinfo.model.gathering.dto.GatheringAlarmDTO;
import com.example.boardinfo.service.gathering.GatheringAlarmService;
import com.example.boardinfo.util.Pager;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@RequestMapping("gatheringAlarm/*")
@Controller
public class GatheringAlarmController {

    @Inject
    GatheringAlarmService gatheringAlarmService;


    @ResponseBody
    @RequestMapping("/list.do")
    public Map<String, List<GatheringAlarmDTO>> list
    (@RequestParam(value="curPage", required=false, defaultValue="1") int curPage,
     @RequestParam(value="size", required=false, defaultValue="20") int size,
     HttpSession session,
     HttpServletRequest request) {

        String user_id = (String) session.getAttribute("userid");
        int count = gatheringAlarmService.countTotList(user_id);
        Pager pager = new Pager(count, curPage, size);
        int start = pager.getPageBegin();
        int end = pager.getPageEnd();
        List<GatheringAlarmDTO> list = gatheringAlarmService.getAlarmList(user_id, start, end, request);
        Map<String, List<GatheringAlarmDTO>> map = new HashMap<>();
        map.put("list", list);

        return map;
    }


    @ResponseBody
    @RequestMapping("read.do")
    public void read(@RequestParam int alarm_id, HttpSession session){
        String user_id = (String) session.getAttribute("userid");
        gatheringAlarmService.read(alarm_id, user_id);
    }
}
