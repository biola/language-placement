class ExamUrlGenerator

  BASE_URL = 'http://webcape.byuhtrsc.org'
  attr_reader :exam_attempt_uid, :exam_type_code

  def initialize(exam_attempt_uid, exam_type_code)
    @exam_attempt_uid = exam_attempt_uid
    @exam_type_code = exam_type_code
  end

  def exam_url(return_url)
    exam_url = base_url.merge('/nwcexam.php')
    exam_url.query = base_query_string.merge(pass: Settings.webcape.pass, url: return_url).to_query
    exam_url.to_s
  end

  def results_url
    results_url = base_url.merge('/nwcresult.php')
    results_url.query = base_query_string.merge(pin: Settings.webcape.pin, fmt: "csv", since: "x").to_query
    results_url.to_s
  end

  private
  def base_url
    @base_url ||= URI.parse(BASE_URL)
  end

  def base_query_string
    { acct: Settings.webcape.acct, lang: exam_type_code, extid: exam_attempt_uid }
  end

end