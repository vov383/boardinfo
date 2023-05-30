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
            Document doc = parseXML(id);

            if (doc != null) {
                this.bgg_thumbnail = parseThumbnail(doc);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public double getBgg_rate() {
        return bgg_rate;
    }

    public void setBgg_rate(int id) {
            this.bgg_rate = bgg_rate;
    }

    public double getBgg_weight() {
        return bgg_weight;
    }

    public void setBgg_weight(int id) {
        this.bgg_weight = bgg_weight;
    }

    public int getBgg_rank() {
        return bgg_rank;
    }

    public void setBgg_rank(int id) {
            this.bgg_rank = bgg_rank;
    }

    public void setBggInfo(int id) {
        try {
            String url = "https://boardgamegeek.com/xmlapi2/thing?id=" + id + "&stats=1";
            Document doc = parseXML(id);

            if (doc != null) {
                this.bgg_thumbnail = parseThumbnail(doc);
                this.bgg_rate = parseRating(doc);
                this.bgg_weight = parseWeight(doc);
                this.bgg_rank = parseRank(doc);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private Document parseXML(int id) {
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

    private String parseThumbnail(Document doc) {
        bgg_thumbnail = "";
        NodeList nList = doc.getElementsByTagName("thumbnail");
        for (int temp = 0; temp < nList.getLength(); temp++) {
            Node nNode = nList.item(temp);
            if (nNode.getNodeType() == Node.ELEMENT_NODE) {
                Element eElement = (Element) nNode;
                bgg_thumbnail = eElement.getTextContent();
            }
        }
        return bgg_thumbnail;
    }

    private double parseRating(Document doc) {
        bgg_rate = 0.00;
        NodeList nList = doc.getElementsByTagName("average");
        for (int temp = 0; temp < nList.getLength(); temp++) {
            Node nNode = nList.item(temp);
            if (nNode.getNodeType() == Node.ELEMENT_NODE) {
                Element eElement = (Element) nNode;
                bgg_rate = Double.parseDouble(eElement.getAttribute("value"));
            }
        }
        return bgg_rate;
    }

    private double parseWeight(Document doc) {
        bgg_weight = 0.00;
        NodeList nList = doc.getElementsByTagName("averageweight");
        for (int temp = 0; temp < nList.getLength(); temp++) {
            Node nNode = nList.item(temp);
            if (nNode.getNodeType() == Node.ELEMENT_NODE) {
                Element eElement = (Element) nNode;
                bgg_weight = Double.parseDouble(eElement.getAttribute("value"));
            }
        }
        return bgg_weight;
    }

    private int parseRank(Document doc) {
        bgg_rank = 0;
        NodeList nList = doc.getElementsByTagName("rank");
        for (int temp = 0; temp < nList.getLength(); temp++) {
            Node nNode = nList.item(temp);
            if (nNode.getNodeType() == Node.ELEMENT_NODE) {
                Element eElement = (Element) nNode;
                bgg_rank = Integer.parseInt(eElement.getAttribute("value"));
            }
        }
        return bgg_rank;
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
