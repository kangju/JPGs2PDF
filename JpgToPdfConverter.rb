#!ruby
#coding: utf-8

require 'prawn'

OUTPUTFOLDER = "/Volumes/kangju/manga/pdf/"

def deleteall(delthem)
  if FileTest.directory?(delthem) then  # ディレクトリかどうかを判別
    Dir.foreach( delthem ) do |file|    # 中身を一覧
      next if /^\.+$/ =~ file           # 上位ディレクトリと自身を対象から外す
      deleteall( delthem.sub(/\/+$/,"") + "/" + file )
    end
    Dir.rmdir(delthem) rescue ""        # 中身が空になったディレクトリを削除
  else
    File.delete(delthem) if File.exist?(delthem) and File::ftype(delthem) == "file"              # ディレクトリでなければ削除
  end
end

def createPdf(targetFolderName)
	outfilename = File.basename(targetFolderName).strip + ".pdf"
	searchtext = "#{targetFolderName}/*.jpg"
	puts searchtext
	firstpage = true

	begin
		imgs = Dir.glob(searchtext)

		if(imgs.length < 1) then
			puts "img not found"
			return false
		end

		imgs.sort!

		Prawn::Document.generate(OUTPUTFOLDER+outfilename) do
			imgs.each do |img|
				start_new_page unless firstpage
				image(img,
				 :at => [-1*bounds.absolute_left, bounds.absolute_top],
				 :fit => [bounds.absolute_right+bounds.absolute_left, bounds.absolute_top+bounds.absolute_bottom])
				firstpage = false
			end
		end

		puts "#{outfilename} created"

		return true
	rescue Exception => e
		puts e.message
		return false
	end
end

fpath = ARGV.pop

if(fpath == nil) then 
	puts "plz input target path"
	exit 1
end

if !File.directory?(fpath) then
	puts "input path is not directory."
	exit 1
end

Dir.glob(fpath+"/*") { |file|
	next if !File.directory? file
	puts "find directory:#{file}"
	deleteall file if createPdf file
}