package com.mall.order.action;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.Toolkit;
import java.awt.image.BufferedImage;
import java.awt.image.FilteredImageSource;
import java.awt.image.ImageFilter;
import java.awt.image.ImageProducer;
import java.awt.image.RGBImageFilter;
import java.io.File;

import javax.imageio.ImageIO;

import net.sourceforge.barbecue.Barcode;
import net.sourceforge.barbecue.BarcodeException;
import net.sourceforge.barbecue.BarcodeFactory;
import net.sourceforge.barbecue.BarcodeImageHandler;
import net.sourceforge.barbecue.output.OutputException;

public class CreateBarcode {
	// FIX 이미지 기본 넓이(바코드기준 사이즈로 변형되기때문에 1이상이면됨)
	private static int IMAGE_WIDTH = 230;
	// FIX 이미지 기본 높이(바코드기준 사이즈로 변형되기때문에 1이상이면됨)
	private static int IMAGE_HEIGHT = 80;
	// 바코드 기본 넓이
	private static int BARCODE_WIDTH = 1;
	// 바코드 기본 높이
	private static int BARCODE_HEIGHT = 60;
	// 배경색 RGB 중 R 값
	private static int COLOR_R = 255;
	// 배경색 RGB 중 G 값
	private static int COLOR_G = 255;
	// 배경색 RGB 중 B 값
	private static int COLOR_B = 255;
	// 배경 투명 처리(불투명 0, 투명 1)
	private static Boolean TYPE_TRANS = false;
	// 이미지 타입[BASE64 - png(투명처리가능), jpeg & SAVE - png, jpeg , gif]
	private static String TYPE_IMAGE = "png";
	// 저장 전체 경로 + 파일명
	private static String SAVE_FULL_PATH = "";
	
	
	
	public static String saveBarcodeImage(String barcodeText, String savePath, int boacodeWidth, int boacodeHeight) throws BarcodeException, OutputException{
		
		BARCODE_WIDTH = boacodeWidth;
		BARCODE_HEIGHT = boacodeHeight;
		
		SAVE_FULL_PATH = savePath + "/" + barcodeText + "."+ TYPE_IMAGE;
		
		createBarcodeImage(barcodeText);
		
		String path = SAVE_FULL_PATH;
		
		return path;
	}



	public static void createBarcodeImage(String barcodeText) throws BarcodeException, OutputException{
		
		Barcode barcode = null;
		BufferedImage image = null;
		Graphics2D g = null;
		
		barcode = BarcodeFactory.createCode128(barcodeText);
		barcode.setBarWidth(BARCODE_WIDTH);
		barcode.setBarHeight(BARCODE_HEIGHT);
		image = new BufferedImage(IMAGE_WIDTH, IMAGE_HEIGHT, BufferedImage.TYPE_BYTE_GRAY);
		g = (Graphics2D) image.getGraphics();
		barcode.draw(g, 10, 56);
		g.dispose();
		
		try {
			if(TYPE_TRANS){//바코드 투명 처리
		    	BufferedImage source = BarcodeImageHandler.getImage(barcode);
		        Image imageTrans = makeColorTransparent(source, new Color(COLOR_R,COLOR_G,COLOR_B));
		        image = imageToBufferedImage(imageTrans);
		        ImageIO.write(image, TYPE_IMAGE, new File(SAVE_FULL_PATH));
	    	}else{
	    		if(TYPE_IMAGE.toLowerCase().equals("png")){
	    			BarcodeImageHandler.savePNG(barcode, new File(SAVE_FULL_PATH));
	    		}else if(TYPE_IMAGE.toLowerCase().equals("gif")){
	    			BarcodeImageHandler.saveGIF(barcode, new File(SAVE_FULL_PATH));
	    		}else if(TYPE_IMAGE.toLowerCase().equals("jpeg") || TYPE_IMAGE.toLowerCase().equals("jpg")){
	    			BarcodeImageHandler.saveJPEG(barcode, new File(SAVE_FULL_PATH));
	    		}else{
	    			BarcodeImageHandler.savePNG(barcode, new File(SAVE_FULL_PATH));	
	    		}
	    	}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
	private static BufferedImage imageToBufferedImage(Image image) {
        BufferedImage bufferedImage = new BufferedImage(image.getWidth(null), image.getHeight(null), BufferedImage.TYPE_INT_ARGB);
        Graphics2D g2 = bufferedImage.createGraphics();
        g2.drawImage(image, 0, 0, null);
        g2.dispose();
        return bufferedImage;
    }
	
	
	
	public static Image makeColorTransparent(BufferedImage im, final Color color) {
        ImageFilter filter = new RGBImageFilter() {
            // the color we are looking for... Alpha bits are set to opaque
            public int markerRGB = color.getRGB() | 0xFF000000;
            public final int filterRGB(int x, int y, int rgb) {
                if ((rgb | 0xFF000000) == markerRGB) {
                    // Mark the alpha bits as zero - transparent
                    return 0x00FFFFFF & rgb;
                } else {
                    // nothing to do
                    return rgb;
                }
            }
        };
        ImageProducer ip = new FilteredImageSource(im.getSource(), filter);
        return Toolkit.getDefaultToolkit().createImage(ip);
    }
}
