from scrapy.contracts import Contract
from scrapy.http import FormRequest


class FilersFormContract(Contract):
    name = 'filers_form'
    request_cls = FormRequest

    def adjust_request_args(self, args):
        args['formdata'] = {'clearCache': 'F', 'page': '1'}
        return args


class FilingsFormContract(Contract):
    name = 'filings_form'
    request_cls = FormRequest

    def adjust_request_args(self, args):
        args['formdata'] = {'srFilerId': '100181,105304'}
        return args
