package com.kb.star.command.addFunction;

import java.io.File;
import java.util.Map;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kb.star.dto.AorBDto;
import com.kb.star.util.AorBDao;

public class MakeAorBCommand implements Command {

	private AorBDao aorBDao;

	public MakeAorBCommand(AorBDao aorBDao) {
		this.aorBDao = aorBDao;
	}

	@Override
	public void execute(Model model) {

		System.out.println("MakeAorBCommand 들어옴");


		Map<String, Object> map = model.asMap();
        MultipartHttpServletRequest request = (MultipartHttpServletRequest) map.get("request");


		String realFolder = "";
		String saveFolder = "uploads";
		MultipartFile variantA = request.getFile("variantA");
		MultipartFile variantB = request.getFile("variantB");

		AorBDto aorBDto = new AorBDto();

		realFolder = request.getSession().getServletContext().getRealPath(saveFolder);

		// Ensure the directory exists
		File uploadDir = new File(realFolder);
		if (!uploadDir.exists()) {
			uploadDir.mkdirs();
		}

		try {
			request.setCharacterEncoding("UTF-8");

			// Handle file upload
			String filenameA = null;
			String filenameB = null;

			if (variantA != null && !variantA.isEmpty()) {
				filenameA = variantA.getOriginalFilename();
				File fileA = new File(realFolder + "/" + filenameA);
				variantA.transferTo(fileA);
				System.out.println("File A uploaded to: " + fileA.getAbsolutePath());
			} else {
				System.out.println("variantA is null or empty");
			}

			if (variantB != null && !variantB.isEmpty()) {
				filenameB = variantB.getOriginalFilename();
				File fileB = new File(realFolder + "/" + filenameB);
				variantB.transferTo(fileB);
				System.out.println("File B uploaded to: " + fileB.getAbsolutePath());
			} else {
				System.out.println("variantB is null or empty");
			}

			// Set DTO properties
			aorBDto.setTestName(request.getParameter("testName"));
			aorBDto.setVariantA(filenameA);
			aorBDto.setVariantB(filenameB);

			// Insert into the database
			aorBDao.makeAorB(aorBDto.getTestName(), aorBDto.getVariantA(), aorBDto.getVariantB());

		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
}