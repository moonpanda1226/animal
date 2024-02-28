package org.sh.service;

import java.util.List;

import org.sh.dto.GalleryDTO;

public interface GalleryService {
	
	public int galleryInsert(GalleryDTO dto);
	
	public List<GalleryDTO> galleryList();
	
	public GalleryDTO detail(String no);

}
