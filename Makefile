lm20.db : filer.csv filing.csv attachment.csv 
	csvs-to-sqlite $^ $@
	sqlite-utils transform $@ filer \
            --pk=srNum \
            --drop filerType \
            --column-order srNum \
            --column-order companyName \
            --column-order companyCity \
            --column-order companyState
	sqlite-utils transform $@ filing \
            --pk=rptId \
            --drop files \
            --drop termDate \
            --drop amount \
            --drop empTrdName
	sqlite-utils transform $@ attachment \
            --pk=attachment_id \
            --drop files
	sqlite-utils add-foreign-key $@ filing srNum filer srNum
	sqlite-utils add-foreign-key $@ attachment rptId filing rptId

attachment.csv :
	scrapy crawl attachments -O $@

filing.csv :
	scrapy crawl filings -O $@

filer.csv :
	scrapy crawl filers -O $@
