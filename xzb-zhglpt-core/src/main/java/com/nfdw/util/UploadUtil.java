package com.nfdw.util;

import com.nfdw.exception.MyException;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.UUID;

/**
 * Created by meng on 2018/5/8.
 * 文件上传工具类
 */
@Getter
@Setter
@ConfigurationProperties
@Component
public class UploadUtil {

	/**
	 * 按照当日创建文件夹
	 */
	@Value("${lenosp.isDayType}")
	private boolean isDayType;
	/**
	 * 自定义文件路径
	 */
	@Value("${lenosp.uploadPath}")
	private String uploadPath;

	@Value("${lenosp.imagePath}")
	private String imagePath;

	@Value("${lenosp.filePath}")
	private String filePath;

	public static final String ROOT_PATH=System.getProperty("user.dir");

	public static final String IMAGE_SUFFIX = "bmp,jpg,png,gif,jpeg";

	public UploadUtil() {
	}

	public String upload(MultipartFile multipartFile) {
		if (isNull(multipartFile)) {
			throw new MyException("上传数据/地址获取异常");
		}

		LoadType loadType = fileNameStyle(multipartFile);
		try {
			FileUtils.copyInputStreamToFile(multipartFile.getInputStream(), loadType.getCurrentFile());
		} catch (IOException e) {
			e.printStackTrace();
		}
		return loadType.getFileName();
	}

	/**
	 * 格式化文件名 默认采用UUID
	 *
	 * @return
	 */
	public LoadType fileNameStyle(MultipartFile multipartFile) {
		String curr = multipartFile.getOriginalFilename();
		int suffixLen = curr.lastIndexOf(".");
		if (suffixLen == -1) {
			throw new MyException("文件获取异常");
		}
		String suffix = curr.substring(suffixLen, curr.length());
		int index = Arrays.binarySearch(IMAGE_SUFFIX.split(","),
				suffix.replace(".", ""));

		curr = UUID.randomUUID() + suffix;
		LoadType loadType = new LoadType();
		loadType.setFileName(curr);
		//image 情况
		curr = StringUtils.isEmpty(imagePath) || index == -1 ?
				uploadPath + File.separator + curr : imagePath + File.separator + curr;
		loadType.setCurrentFile(new File(curr));
		return loadType;
	}

	/**
	 * 多文件上传
	 * @param multipartFile
	 * @param path
	 * @return
	 */
	public com.nfdw.entity.File upload(MultipartFile multipartFile, Path path) {

		if(isNull(multipartFile))
			throw new MyException("上传数据/地址获取异常");

		LoadType loadType = fileNameStyle(multipartFile,path);
		com.nfdw.entity.File file=null;
		try {
			FileUtils.copyInputStreamToFile(multipartFile.getInputStream(), loadType.getCurrentFile());
			file= new com.nfdw.entity.File(multipartFile.getOriginalFilename(), loadType.getFileName()
					, multipartFile.getSize(),path.getType());
		} catch (IOException e) {
			e.printStackTrace();
		}
		return file;
	}

	/**
	 * 多文件格式化文件名 默认采用UUID
	 *
	 * @return
	 */
	public LoadType fileNameStyle(MultipartFile multipartFile, Path path) {
		String curr = multipartFile.getOriginalFilename();
		int suffixLen = curr.lastIndexOf(".");
		if (suffixLen == -1) {
			throw new MyException("文件获取异常");
		}
		String suffix = curr.substring(suffixLen, curr.length());

		curr = UUID.randomUUID() + suffix;
		LoadType loadType = new LoadType();
		loadType.setFileName(curr);

		curr = this.filePath + path.getPath() + File.separator + curr;
		loadType.setCurrentFile(new File(curr));
		return loadType;
	}

	protected boolean isNull(MultipartFile multipartFile) {
		if (null != multipartFile) {
			return false;
		}
		return true;
	}

	public byte[] download(com.nfdw.entity.File file, Path path) throws IOException {
		if(null==file) {
			throw new MyException("获取文件有误异常");
		}
		String curr=file.getFilePath();
		curr = this.filePath + path.getPath() + File.separator + curr;
        
		return FileUtils.readFileToByteArray(new File(curr));
	}
	
	public void deleteFile(String filePath, Path path) {
		if(StringUtils.isEmpty(filePath)) {
			throw new MyException("获取文件名有误异常或者没有该文件");
		}
		String curr=filePath;
		curr = this.filePath + path.getPath() + File.separator + curr;
		
		FileUtils.deleteQuietly(new File(curr));
		
	}

}

@Data
class LoadType {
	private String fileName;
	private File currentFile;
}
