package org.sh.controller;

import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;

import org.sh.dto.GalleryDTO;
import org.sh.service.GalleryService;
import org.sh.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ImportResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class GalleryController {

	@Resource(name="galleryService") 
	private GalleryService galleryService;

	@Autowired
	private Util util;

	@GetMapping("/gallery")
	public String gallery(Model model) {
		List<GalleryDTO> list = galleryService.galleryList();
		model.addAttribute("list", list);

		return "gallery";
	}

	@GetMapping("/galleryInsert")
	public String galleryInsert() {
		return "galleryInsert";
	}

	@PostMapping("/galleryInsert")
	public String galleryInsert(GalleryDTO dto, @RequestParam("file1") MultipartFile upFile) {
		System.out.println(dto.getGtitle());
		System.out.println(dto.getGcontent());

		// 파일 업로드 -> util
		String newFileName = util.fileUpload(upFile);

		dto.setGfile(newFileName); // UUID+

		int result = galleryService.galleryInsert(dto);
		return "redirect:/gallery";
	}
	
	//galleryDetail
	//2024-02-26 요구사항 확인 psd
	@GetMapping("/galleryDetail@{no}")
	public String galleryDetail(@PathVariable("no") String no, Model model) {
		//System.out.println("경로 | : " + no);
		if(util.intCheck(no)) {
			GalleryDTO detail = galleryService.detail(no);
			
			model.addAttribute("detail", detail);
			return "galleryDetail";
		}else {
			
			return "redirect:/error";
		}
	}

}
