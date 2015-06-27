require 'prawn'

module Jpgs2Pdf
   class Jpgs2Pdf
      def Jpgs2Pdf.toPdf(targetFolderName,outputPdfFilePath)
         searchtext = "#{targetFolderName}/*.jpg"

         imgs = Dir.glob(searchtext).sort!

         return false if imgs.empty?

         Prawn::Document.generate(outputPdfFilePath,:margin => [0,0]) do
            imgs.each do |img|
               image(img,
                :vposition => :center,
                :position => :center,
                :fit => [bounds.right+bounds.absolute_left - 1, bounds.absolute_top+bounds.absolute_bottom - 1])
            end
         end

         return true
      end
   end
end