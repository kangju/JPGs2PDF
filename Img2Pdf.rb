require 'prawn'

module Jpgs2Pdf
   class Jpgs2Pdf
      def Jpgs2Pdf.toPdf(targetFolderName,outputPdfFilePath)
         searchtext = "#{targetFolderName}/*.jpg"
         firstpage = true

         imgs = Dir.glob(searchtext).sort!

         return false if imgs.empty?

         Prawn::Document.generate(outputPdfFilePath) do
            imgs.each do |img|
               start_new_page unless firstpage
               image(img,
                :vposition => :center,
                :position => :center,
                :fit => [bounds.absolute_right+bounds.absolute_left, bounds.absolute_top+bounds.absolute_bottom])
               firstpage = false
            end
         end

         return true
      end
   end
end