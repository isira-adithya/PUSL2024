package com.isiraadithya.greensupermarket.helpers;
import org.jsoup.Jsoup;
import org.jsoup.safety.Safelist;
import org.apache.commons.lang3.StringEscapeUtils;

public class XSSPreventor {
    public static String sanitizeHtml(String html) {
        // Use JSoup library to clean and sanitize HTML input
        return Jsoup.clean(html, Safelist.basic());
    }

    public static String encodeToHtmlEntities(String text) {
        // Use Apache Commons Lang to encode text to HTML entities
        return StringEscapeUtils.escapeHtml4(text);
    }
}
