# prefer json gem style output when use Oj.dump or Oj.load
# default mode is :object, which will get ':a' => 1 json output
Oj.default_options = {:mode => :compat}

# monkey patch rails core to_json() use Oj version
# -> this method only work for rails 4.1 later
Oj.mimic_JSON()
Oj.add_to_json()

