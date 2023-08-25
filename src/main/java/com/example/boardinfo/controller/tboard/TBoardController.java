package com.example.boardinfo.controller.tboard;

import com.example.boardinfo.model.tboard.dto.TBoardDTO;
import com.example.boardinfo.model.tboard.dto.TradeSearchDTO;
import com.example.boardinfo.service.tboard.TBCommentService;
import com.example.boardinfo.service.tboard.TBoardService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.HtmlUtils;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
@RequestMapping("tboard/*")
public class TBoardController {

    //로깅
    private static final Logger logger
            = LoggerFactory.getLogger(TBoardController.class);

    @Inject
    TBoardService tboardService;

    @Inject
    TBCommentService tbcommentService;

    @RequestMapping("list")
    @ResponseBody
    public ModelAndView list(
            @RequestParam(defaultValue = "all") String category,
            @RequestParam(defaultValue = "all") String search_option,
            @RequestParam(defaultValue = "") String keyword,
            @RequestParam(defaultValue = "1") int curPage) throws Exception {

        //레코드 갯수 계산
        /*sDto는 검색form  DTO*/


        TradeSearchDTO sDto = new TradeSearchDTO();
        sDto.setCategory(category);
        sDto.setSearch_option(search_option);
        sDto.setKeyword("%" + keyword + "%");
        sDto.setCurPage(curPage);
        int count = tboardService.countArticle(
                sDto);

        Map<String, Object> map = tboardService.list(sDto);
        ModelAndView mav = new ModelAndView();

        mav.setViewName("tboard/list");
        mav.addObject("map", map);
        return mav;
    }

    @GetMapping("write")
    public String write(HttpSession session) {
        //글쓰기 폼 페이지로 이동
        String userid = (String) session.getAttribute("userid");
        if (userid == null || userid.equals("")) {
            return "member/login";
        }
        return "tboard/write";
    }

    @PostMapping("insert.do")
    public String insert(
            @RequestParam(value = "files", required = false) MultipartFile[] files,
            @RequestParam(value = "title") String title, @RequestParam(value = "price") String price, @RequestParam(value = "description") String description, @RequestParam(value = "category") String category, @RequestParam(value = "address1", required = false) String address1, @RequestParam(value = "address2", required = false) String address2, @RequestParam(value = "address3", required = false) String address3, @RequestParam(value = "place_name", required = false) String place_name, @RequestParam(value = "lat", required = false) String lat, @RequestParam(value = "lng", required = false) String lng, HttpSession session, HttpServletRequest request
    ) throws Exception {
        //로그인 한 사람만 들어올 수 있으니까 HttpSession 써야함
        String userid = (String) session.getAttribute("userid");
        String admin_id = (String) session.getAttribute("admin_id");
        if (userid == "" && admin_id == "") {
            return "member/login";
        } else {
            TBoardDTO dto = new TBoardDTO();
            dto.setTitle(title);
            dto.setPrice(String.valueOf(price));
            dto.setDescription(description);
            dto.setCategory(category);
            dto.setAddress1(address1);
            dto.setAddress2(address2);
            dto.setAddress3(address3);
            dto.setPlace_name(place_name);

            //여기서 lat이 null이라서 nullpointexception
            //Optional 사용하여 null 체크, 없으면 빈값 들어감.
            dto.setLat(Optional.ofNullable(lat).get());
            dto.setLat(Optional.ofNullable(lng).get());

            //이름이 없기 때문에 session에서 id를 가져와야 한다.
            if (userid != "") {
                String create_user = userid;
                dto.setCreate_user(create_user);
                String uploadPath = request.getSession().getServletContext().getRealPath("/resources/uploaded_image");
                //게시물 저장
                tboardService.insert(dto, files, uploadPath);
            } else {
                String create_user = admin_id;
                dto.setCreate_user(create_user);
                String uploadPath = request.getSession().getServletContext().getRealPath("/resources/uploaded_image");
                //게시물 저장
                tboardService.insert(dto, files, uploadPath);
            }

        }
        //게시물 목록 갱신처리
        return "redirect:/tboard/list";
    }

    @RequestMapping("view/{tb_num}")
    public ModelAndView view(@PathVariable("tb_num") String tb_num,
                             HttpSession session) throws Exception {
        //조회수 증가처리
        tboardService.increaseViewCount(tb_num, session);
        Map<String, Object> map = tboardService.viewPost(tb_num);

        ModelAndView mav = new ModelAndView();

        mav.setViewName("tboard/viewPost");
        mav.addObject("map", map);

        return mav;

    }

    @GetMapping("change/{tb_num}")
    public ModelAndView moveUpdatePage(@PathVariable String tb_num) {

        Map<String, Object> map = tboardService.viewPost(tb_num);

        /*수정 페이지로 이동 전에 html 특수문자 encode한 거 decode*/
        TBoardDTO dto = (TBoardDTO) map.get("dto");
        dto.setTitle(HtmlUtils.htmlUnescape(dto.getTitle()));
        dto.setDescription(HtmlUtils.htmlUnescape(dto.getDescription()));
        /*price가 null인 경우에 nullPointException 발생하기 때문에
        값이 null인 경우와 아닌 경우 분기*/
        if (dto.getPrice() != null) {
            dto.setPrice(HtmlUtils.htmlUnescape(dto.getPrice()));
            dto.setPrice(dto.getPrice().replace(",", ""));
            logger.info("@@@@프라이스 찍어보기" + dto.getPrice());
        }

        map.put("dto", dto);

        List<String> tbfList = tboardService.getAttach(tb_num);
        map.put("tbfList", tbfList);
        ModelAndView mav = new ModelAndView();
        mav.setViewName("tboard/updatePost");
        mav.addObject("map", map);
        return mav;
    }

    @RequestMapping("update.do")
    public String update(
            @RequestParam(value = "files", required = false) MultipartFile[] files,
            @RequestParam(value = "title") String title, @RequestParam(value = "price") String price, @RequestParam(value = "description") String description, @RequestParam(value = "category") String category, @RequestParam(value = "address1", required = false) String address1, @RequestParam(value = "address2", required = false) String address2, @RequestParam(value = "address3", required = false) String address3, @RequestParam(value = "place_name", required = false) String place_name, @RequestParam(value = "lat", required = false) String lat, @RequestParam(value = "lng", required = false) String lng, HttpSession session, HttpServletRequest request)
            throws Exception {

        //로그인 한 사람만 들어올 수 있으니까 HttpSession 써야함
        String userid = (String) session.getAttribute("userid");
        String admin_id = (String) session.getAttribute("admin_id");
        price = price.replaceAll("[^\\w+]", "");

        if (userid == "" && admin_id == "") {
            return "member/login";
        } else {
            TBoardDTO dto = new TBoardDTO();
            dto.setTitle(title);
            dto.setPrice(String.valueOf(price));
            dto.setDescription(description);
            dto.setCategory(category);
            dto.setAddress1(address1);
            dto.setAddress2(address2);
            dto.setAddress3(address3);
            dto.setPlace_name(place_name);

            //여기서 lat이 null이라서 nullpointexception
            //null 이 아닌 경우에만
            if (lat != null) {
                dto.setLat(lat);
                dto.setLng(lng);
            }

            //이름이 없기 때문에 session에서 id를 가져와야 한다.
            if (userid != "") {
                String update_user = userid;
                dto.setUpdate_user(update_user);
                String uploadPath = request.getSession().getServletContext().getRealPath("/resources/uploaded_image");

                //게시물 저장
                tboardService.update(dto, files, uploadPath);

            } else if (admin_id != "") {
                String update_user = admin_id;
                dto.setUpdate_user(update_user);
                String uploadPath = request.getSession().getServletContext().getRealPath("/resources/uploaded_image");

                //게시물 저장
                tboardService.update(dto, files, uploadPath);
            }

        }
        //게시물 목록 갱신처리
        return "redirect:/tboard/list";
    }

    @RequestMapping("getAttach")
    @ResponseBody
    public List<String> getAttach(
            @RequestParam("tb_num") String tb_num) {
        return tboardService.getAttach(tb_num);
    }

    @RequestMapping("delete.do")
    public String delete(String tb_num, HttpSession session) {
        tboardService.delete(tb_num);
        return "redirect:/tboard/list";
    }

    @RequestMapping("imageUpload.do")
    public String imageUpload(
    ) {
        return "redirect:/tboard/list";
    }


    @ResponseBody
    @GetMapping("/homeList")
    public Map<String, List<TBoardDTO>> getHomeList(
            @RequestParam(value = "size", required = false) Integer size) {

        if (size == null) size = 8;
        List<TBoardDTO> list = tboardService.getHomeList(size);
        Map<String, List<TBoardDTO>> map = new HashMap<>();
        map.put("list", list);
        return map;
    }

    @RequestMapping("likeCheck.do")
    @ResponseBody
    public ResponseEntity<String> likeCheck(@RequestParam String tb_num, HttpSession session) {
        String userid = (String) session.getAttribute("userid");
        if (userid == null) {
            return new ResponseEntity<>("unchecked", HttpStatus.OK);
        } else {
            String goodkey = userid + tb_num;
            /*true면 checked, false면 unchecked*/
            boolean checked = tboardService.checkLike(goodkey);
            if (checked) {
                return new ResponseEntity<>("checked", HttpStatus.OK);
            } else {
                return new ResponseEntity<>("unchecked", HttpStatus.OK);
            }
        }

    }


    @RequestMapping("addLike.do")
    @ResponseBody
    public Map<String, String> addLike(@RequestParam String tb_num, HttpSession session) {
        Map<String, String> response = tboardService.addLike(session, tb_num);
        return response;
    }

}
