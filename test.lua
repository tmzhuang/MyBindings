local _, MB = ...

function MB.test()
    fname = string.format('get_%s_data', 'mage')
    print(MB[fname])
end
