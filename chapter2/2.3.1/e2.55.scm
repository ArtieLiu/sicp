(car ''abcd)
(car (quote abcd))
(car (quote '(quote abcd)))

''abcd is equivalent to (quote 'abcd) which is equivalent to (quote '(quote abcd))
