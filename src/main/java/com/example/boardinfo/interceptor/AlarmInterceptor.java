package com.example.boardinfo.interceptor;

import com.example.boardinfo.model.gathering.dao.GatheringAlarmDAO;
import com.example.boardinfo.model.gathering.dto.ChatRoomDTO;
import com.example.boardinfo.service.gathering.GatheringAlarmService;
import com.example.boardinfo.service.gathering.GatheringService;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

public class AlarmInterceptor extends HandlerInterceptorAdapter {

    @Inject
    GatheringAlarmService gatheringAlarmService;

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

        if (!"XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {

            String requestUrl = request.getRequestURI();

            HttpSession session=request.getSession();
            String user_id = (String)session.getAttribute("userid");
            if(user_id!=null && !user_id.equals("")) {
                gatheringAlarmService.updateSessionByAlarm(user_id, session);
                boolean unread = gatheringAlarmService.checkUnreadAlarm(user_id);
                session.setAttribute("unreadAlarmCount", unread);
            }

        }


    }
}
