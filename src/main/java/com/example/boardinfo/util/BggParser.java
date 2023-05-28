package com.example.boardinfo.util;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

public class BggParser {
    private String bgg_thumbnail;
    private double bgg_rate;
    private double bgg_weight;
    private int bgg_rank;

    public String getBgg_thumbnail() {
        return bgg_thumbnail;
    }

    public void setBgg_thumbnail(int id) {
        try {
            String url = "https://boardgamegeek.com/xmlapi2/thing?id=" + id + "&stats=1";
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.parse(url);
            String bgg_thumbnail = "";
            //썸네일주소 출력
            NodeList nList2 = doc.getElementsByTagName("thumbnail");
            for (int temp = 0; temp < nList2.getLength(); temp++) {
                Node nNode = nList2.item(temp);
                if (nNode.getNodeType() == Node.ELEMENT_NODE) {
                    Element eElement = (Element) nNode;
                    bgg_thumbnail = eElement.getTextContent(); // 파싱text
                } // if end
            } // for end
            this.bgg_thumbnail = bgg_thumbnail;
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public double getBgg_rate() {
        return bgg_rate;
    }

    public void setBgg_rate(int id) {
        try {
            String url = "https://boardgamegeek.com/xmlapi2/thing?id=" + id + "&stats=1";
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.parse(url);
            double bgg_rate = 0.00;
            // 평점출력
            NodeList nList3 = doc.getElementsByTagName("average");
            for (int temp = 0; temp < nList3.getLength(); temp++) {
                Node nNode = nList3.item(temp);
                if (nNode.getNodeType() == Node.ELEMENT_NODE) {
                    Element eElement = (Element) nNode;
                    bgg_rate = Double.parseDouble(eElement.getAttribute("value"));
                } // if end
            } // for end
            this.bgg_rate = bgg_rate;
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public double getBgg_weight() {
        return bgg_weight;
    }

    public void setBgg_weight(int id) {
        try {
            String url = "https://boardgamegeek.com/xmlapi2/thing?id=" + id + "&stats=1";
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.parse(url);
            double bgg_weight = 0.00;
            NodeList nList4 = doc.getElementsByTagName("averageweight");
            for (int temp = 0; temp < nList4.getLength(); temp++) {
                Node nNode = nList4.item(temp);
                if (nNode.getNodeType() == Node.ELEMENT_NODE) {
                    Element eElement = (Element) nNode;
                    bgg_weight = Double.parseDouble(eElement.getAttribute("value"));
                } // if end
            } // for end
        this.bgg_weight = bgg_weight;
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int getBgg_rank() {
        return bgg_rank;
    }

    public void setBgg_rank(int id) {
        try {
            String url = "https://boardgamegeek.com/xmlapi2/thing?id=" + id + "&stats=1";
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.parse(url);

            int bgg_rank = 0;
            // 랭크출력
            NodeList nList5 = doc.getElementsByTagName("rank");
            for (int temp = 0; temp < nList5.getLength(); temp++) {
                Node nNode = nList5.item(temp);
                if (nNode.getNodeType() == Node.ELEMENT_NODE) {
                    Element eElement = (Element) nNode;
                    bgg_rank = Integer.parseInt(eElement.getAttribute("value"));
                } // if end
            } // for end
            this.bgg_rank = bgg_rank;
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

//    public BggParser(int id) {
//
//        try {
//            String url = "https://boardgamegeek.com/xmlapi2/thing?id=" + id + "&stats=1";
//            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
//            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
//            Document doc = dBuilder.parse(url);
//
//            //썸네일주소 출력
//            NodeList nList2 = doc.getElementsByTagName("thumbnail");
//            for (int temp = 0; temp < nList2.getLength(); temp++) {
//                Node nNode = nList2.item(temp);
//                if (nNode.getNodeType() == Node.ELEMENT_NODE) {
//                    Element eElement = (Element) nNode;
//                    System.out.println("썸네일주소 : " + eElement.getTextContent()); // 파싱text
//                } // if end
//            } // for end
//
//            // 평점출력
//            NodeList nList3 = doc.getElementsByTagName("average");
//            for (int temp = 0; temp < nList3.getLength(); temp++) {
//                Node nNode = nList3.item(temp);
//                if (nNode.getNodeType() == Node.ELEMENT_NODE) {
//                    Element eElement = (Element) nNode;
//                    System.out.println("평점 :::" + eElement.getAttribute("value"));
//                } // if end
//            } // for end
//
//
//            // 난이도출력
//            NodeList nList4 = doc.getElementsByTagName("averageweight");
//            for (int temp = 0; temp < nList4.getLength(); temp++) {
//                Node nNode = nList4.item(temp);
//                if (nNode.getNodeType() == Node.ELEMENT_NODE) {
//                    Element eElement = (Element) nNode;
//                    System.out.println("난이도 :::" + eElement.getAttribute("value"));
//                } // if end
//            } // for end
//
//            // 랭크출력
//            NodeList nList5 = doc.getElementsByTagName("rank");
//            for (int temp = 0; temp < nList5.getLength(); temp++) {
//                Node nNode = nList5.item(temp);
//                if (nNode.getNodeType() == Node.ELEMENT_NODE) {
//                    Element eElement = (Element) nNode;
//                    System.out.println("랭크 :::" + eElement.getAttribute("value"));
//                } // if end
//            } // for end
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }


}
