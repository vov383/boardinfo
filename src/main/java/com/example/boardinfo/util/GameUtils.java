package com.example.boardinfo.util;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.util.ArrayList;
import java.util.List;

public class GameUtils {

    //리스트로 받은 값을 String 타입으로 변환
    public static String listToStr(List<String> list){
        StringBuilder strbuilder = new StringBuilder();
        String result = "";

        //리스트를 출력후 합침
        for(String str : list){
            strbuilder.append(str).append(",");
        }
        result = strbuilder.toString();

        if(result.indexOf("(unknown)") != -1)
            return null;
        else
            return result;
    }

    //위의 listToStr메소드의 String값의 맨마지막 ',' 제거하는 메소드
   public static String removeLastChar(String str) {
        if (str == null || str.length() == 0) {
            return str;
        }
        return str.substring(0, str.length() - 1);
    }

    //클라이언트로부터 input받은 값들의 null값 여부 확인후 null이면 (unknown)을,
    // 아니면 ',' 기준으로 나눈 배열로 리턴하는 메소드
    public static String[] checkNullnSplit(String str){
        //null값이 들어오면
        if(str == null || str == ""){
            str = "(unknown)";
        }
        //배열로 리턴
        return str.split(",");
    }

    //보드게임긱 사이트를 파싱해오는 document객체
    private static Document parseXML(int id) {
        try {
            String url = "https://boardgamegeek.com/xmlapi2/thing?id=" + id + "&stats=1";
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            return dBuilder.parse(url);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    //파싱의 결과값이 문자열인 경우 컨트롤러와 통신할 메서드.
    //썸네일의 경우 단독으로 사용되며 xml의 text부분을 가져와야해서 분기를 나누었음
    public static String setStr(int id, String item) {
        String str = "";
        try {
            Document doc = parseXML(id);

            if (doc != null) {
                if(item.indexOf("thumbnail") != -1){
                    str = parseThumbnail(doc);
                }else {
                    str = parseStr(doc, item);
                }
                return str;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    //리스트로 받아야하는 artist,category, designer, mechanic, publisher를
    // 컨트롤러로 요청받아 보내는 메서드
    public static List<String> setList(int id, String item) {
        List<String> list = new ArrayList<>();
        try {
            Document doc = parseXML(id);

            if (doc != null) {
                list = parseList(doc, item);
            }
            return list;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    //리스트타입의 값을 추출하는 메서드
    private static List<String> parseList(Document doc, String item) {
        List<String> list = new ArrayList<>();
        NodeList nList = doc.getElementsByTagName("link");
        if(nList.getLength() >= 1) {
            for (int temp = 0; temp < nList.getLength(); temp++) {
                Node nNode = nList.item(temp);
                if (nNode.getNodeType() == Node.ELEMENT_NODE) {
                    Element eElement = (Element) nNode;
                    if (eElement.getAttribute("type").equals(item)) {
                        String str = eElement.getAttribute("value").replace(",",".");
                        list.add(str);
                    }
                }
            }
            return list;
        } else
            return null;
    }

    //문자열의 값들을 추출하는 메서드
    private static String parseStr(Document doc, String item) {
        String str = "";
        NodeList nList = doc.getElementsByTagName(item);

        for (int temp = 0; temp < nList.getLength(); temp++) {
            Node nNode = nList.item(temp);
            if (nNode.getNodeType() == Node.ELEMENT_NODE) {
                Element eElement = (Element) nNode;
                if(item.indexOf("name") != -1){
                    String type = eElement.getAttribute("type");
                    if (type.equals("primary")) {
                        str = eElement.getAttribute("value").replace(",", ".");
                        break;
                    }
                } else {
                    str = eElement.getAttribute("value").replace(",", ".");
                }
            }
        }
        return GameUtils.removeLastChar(str);
    }

    //썸네일의 경로 문자열을 추출하는 메서드
    private static String parseThumbnail(Document doc) {
        String result = "";
        NodeList nList = doc.getElementsByTagName("thumbnail");
        for (int temp = 0; temp < nList.getLength(); temp++) {
            Node nNode = nList.item(temp);
            if (nNode.getNodeType() == Node.ELEMENT_NODE) {
                Element eElement = (Element) nNode;
                result = eElement.getTextContent();
            }
        }
        return result;
    }





}
