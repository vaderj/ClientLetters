param($installPath, $toolsPath, $package, $project)

Import-Module (Join-Path $toolsPath common.psm1) -Force

try {

    # Indicates if current project is a VB project
    $IsVbProject = ($project.CodeModel.Language -eq [EnvDTE.CodeModelLanguageConstants]::vsCMLanguageVB)
    
    if ($IsVbProject) {

        # Remove added Imports for VB project
        $VbImports | ForEach-Object {
            if ($project.Object.Imports -contains $_) {
                $project.Object.Imports.Remove($_)
            }
        }
    }
    
    # Remove references
    Foreach ($spRef in $ReferencesToRemoveWhenUninstall) {
        $project.Object.References | Where-Object { $_.Identity -eq $spRef } | ForEach-Object { $_.Remove() }
    }
    
} catch {

    Write-Host "Error uninstalling package: " + $_.Exception -ForegroundColor Red
    exit
}
# SIG # Begin signature block
# MIIh8gYJKoZIhvcNAQcCoIIh4zCCId8CAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCAN/6dBHJ45hY+Y
# N8R45TKbxt2wbCsKlOEE8Hxkc3JCuqCCC4QwggUMMIID9KADAgECAhMzAAABT+fG
# YslG9Kl/AAAAAAFPMA0GCSqGSIb3DQEBCwUAMH4xCzAJBgNVBAYTAlVTMRMwEQYD
# VQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNpZ25p
# bmcgUENBIDIwMTAwHhcNMTYxMTE3MjE1OTE0WhcNMTgwMjE3MjE1OTE0WjCBgzEL
# MAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1v
# bmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjENMAsGA1UECxMETU9Q
# UjEeMBwGA1UEAxMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMIIBIjANBgkqhkiG9w0B
# AQEFAAOCAQ8AMIIBCgKCAQEAtImQinYMrMU9obyB6NdQCLtaaaeux8y4W704DyFR
# Rggj0b0imXO3KO/3B6sr+Uj3pRQFqU0kG21hlpyDnTPALHmZ8F3z7NVE36XNWfp2
# rQY/xkoD5uotlBDCZm/9YtBQitEikSOXZTShxJoCXpLiuHwoeMJe40b3yu84V4is
# VgZYypgbx6jXXjaumkUw47a3PRjCpyeweU1T2DLmdqNQKvY/urtBHiSGTZibep72
# LOK8kGBl+5Zp+uATaOKJKi51GJ3Cbbgh9JleKn8xoKcNzO9PEW7+SUJOYd43yyue
# QO/Oq15wCHOlcnu3Rs5bMlNdijlRb7DXqHjdoyhvXu5CHwIDAQABo4IBezCCAXcw
# HwYDVR0lBBgwFgYKKwYBBAGCNz0GAQYIKwYBBQUHAwMwHQYDVR0OBBYEFJIOoRFx
# ti9VDcMP9MlcdC5aDGq/MFIGA1UdEQRLMEmkRzBFMQ0wCwYDVQQLEwRNT1BSMTQw
# MgYDVQQFEysyMzA4NjUrYjRiMTI4NzgtZTI5My00M2U5LWIyMWUtN2QzMDcxOWQ0
# NTJmMB8GA1UdIwQYMBaAFOb8X3u7IgBY5HJOtfQhdCMy5u+sMFYGA1UdHwRPME0w
# S6BJoEeGRWh0dHA6Ly9jcmwubWljcm9zb2Z0LmNvbS9wa2kvY3JsL3Byb2R1Y3Rz
# L01pY0NvZFNpZ1BDQV8yMDEwLTA3LTA2LmNybDBaBggrBgEFBQcBAQROMEwwSgYI
# KwYBBQUHMAKGPmh0dHA6Ly93d3cubWljcm9zb2Z0LmNvbS9wa2kvY2VydHMvTWlj
# Q29kU2lnUENBXzIwMTAtMDctMDYuY3J0MAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcN
# AQELBQADggEBABHAuWpDNf6FsTiADbh0dSyNcUm4PEHtLb3iBjaQdiuJ5baB6Ybj
# GIyWkzJCp6f2tzQlOdDGekPq23dwzNTpQuuoxVUCdXie2BC+BxvKlGP7PA9x7tRV
# Z9cp9mq/B7zlj4Lq+KHiczM/FJJeobplVzdFhYBc1izGizxqh6MHEcvs2XE4IDUk
# PVS9zFWJ9HcQm+WZqg+uxjyOn9oAT8994bPAIPdSMfciSNVhjX8mAhl9g8xhkyrd
# uNziCLOn3+EEd2DI9Kw1yzHlbHVRxTd7E2pOlWuPQJ7ITT6uvVnFINbCeK23ZFs7
# 0MAVcDQU5cWephzH9P/2y0jB4o3zbs6qtKAwggZwMIIEWKADAgECAgphDFJMAAAA
# AAADMA0GCSqGSIb3DQEBCwUAMIGIMQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2Fz
# aGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENv
# cnBvcmF0aW9uMTIwMAYDVQQDEylNaWNyb3NvZnQgUm9vdCBDZXJ0aWZpY2F0ZSBB
# dXRob3JpdHkgMjAxMDAeFw0xMDA3MDYyMDQwMTdaFw0yNTA3MDYyMDUwMTdaMH4x
# CzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRt
# b25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01p
# Y3Jvc29mdCBDb2RlIFNpZ25pbmcgUENBIDIwMTAwggEiMA0GCSqGSIb3DQEBAQUA
# A4IBDwAwggEKAoIBAQDpDmRQeWe1xOP9CQBMnpSs91Zo6kTYz8VYT6mldnxtRbrT
# OZK0pB75+WWC5BfSj/1EnAjoZZPOLFWEv30I4y4rqEErGLeiS25JTGsVB97R0sKJ
# HnGUzbV/S7SvCNjMiNZrF5Q6k84mP+zm/jSYV9UdXUn2siou1YW7WT/4kLQrg3TK
# K7M7RuPwRknBF2ZUyRy9HcRVYldy+Ge5JSA03l2mpZVeqyiAzdWynuUDtWPTshTI
# wciKJgpZfwfs/w7tgBI1TBKmvlJb9aba4IsLSHfWhUfVELnG6Krui2otBVxgxrQq
# W5wjHF9F4xoUHm83yxkzgGqJTaNqZmN4k9Uwz5UfAgMBAAGjggHjMIIB3zAQBgkr
# BgEEAYI3FQEEAwIBADAdBgNVHQ4EFgQU5vxfe7siAFjkck619CF0IzLm76wwGQYJ
# KwYBBAGCNxQCBAweCgBTAHUAYgBDAEEwCwYDVR0PBAQDAgGGMA8GA1UdEwEB/wQF
# MAMBAf8wHwYDVR0jBBgwFoAU1fZWy4/oolxiaNE9lJBb186aGMQwVgYDVR0fBE8w
# TTBLoEmgR4ZFaHR0cDovL2NybC5taWNyb3NvZnQuY29tL3BraS9jcmwvcHJvZHVj
# dHMvTWljUm9vQ2VyQXV0XzIwMTAtMDYtMjMuY3JsMFoGCCsGAQUFBwEBBE4wTDBK
# BggrBgEFBQcwAoY+aHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraS9jZXJ0cy9N
# aWNSb29DZXJBdXRfMjAxMC0wNi0yMy5jcnQwgZ0GA1UdIASBlTCBkjCBjwYJKwYB
# BAGCNy4DMIGBMD0GCCsGAQUFBwIBFjFodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20v
# UEtJL2RvY3MvQ1BTL2RlZmF1bHQuaHRtMEAGCCsGAQUFBwICMDQeMiAdAEwAZQBn
# AGEAbABfAFAAbwBsAGkAYwB5AF8AUwB0AGEAdABlAG0AZQBuAHQALiAdMA0GCSqG
# SIb3DQEBCwUAA4ICAQAadO9XTyl7xBaFeLhQ0yL8CZ2sgpf4NP8qLJeVEuXkv8+/
# k8jjNKnbgbjcHgC+0jVvr+V/eZV35QLU8evYzU4eG2GiwlojGvCMqGJRRWcI4z88
# HpP4MIUXyDlAptcOsyEp5aWhaYwik8x0mOehR0PyU6zADzBpf/7SJSBtb2HT3wfV
# 2XIALGmGdj1R26Y5SMk3YW0H3VMZy6fWYcK/4oOrD+Brm5XWfShRsIlKUaSabMi3
# H0oaDmmp19zBftFJcKq2rbtyR2MX+qbWoqaG7KgQRJtjtrJpiQbHRoZ6GD/oxR0h
# 1Xv5AiMtxUHLvx1MyBbvsZx//CJLSYpuFeOmf3Zb0VN5kYWd1dLbPXM18zyuVLJS
# R2rAqhOV0o4R2plnXjKM+zeF0dx1hZyHxlpXhcK/3Q2PjJst67TuzyfTtV5p+qQW
# BAGnJGdzz01Ptt4FVpd69+lSTfR3BU+FxtgL8Y7tQgnRDXbjI1Z4IiY2vsqxjG6q
# HeSF2kczYo+kyZEzX3EeQK+YZcki6EIhJYocLWDZN4lBiSoWD9dhPJRoYFLv1keZ
# oIBA7hWBdz6c4FMYGlAdOJWbHmYzEyc5F3iHNs5Ow1+y9T1HU7bg5dsLYT0q15Is
# zjdaPkBCMaQfEAjCVpy/JF1RAp1qedIX09rBlI4HeyVxRKsGaubUxt8jmpZ1xTGC
# FcQwghXAAgEBMIGVMH4xCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9u
# MRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRp
# b24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNpZ25pbmcgUENBIDIwMTACEzMA
# AAFP58ZiyUb0qX8AAAAAAU8wDQYJYIZIAWUDBAIBBQCggbIwGQYJKoZIhvcNAQkD
# MQwGCisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUwLwYJ
# KoZIhvcNAQkEMSIEIGKTrQW+/tK2yNEt6W0hJBfFPFEb7X02Xzs+fioEJ1UOMEYG
# CisGAQQBgjcCAQwxODA2oByAGgB1AG4AaQBuAHMAdABhAGwAbAAuAHAAcwAxoRaA
# FGh0dHA6Ly9taWNyb3NvZnQuY29tMA0GCSqGSIb3DQEBAQUABIIBAHg5qI2BBozO
# hriv0m/GgU53+zR5tS7qTN+i/JdvrxhW2HNj7OPIvr8U2bQ4jVgFYxo1SoTLuDVY
# 3QwFc7A1j5bYSP2EyshYPxzeik0R6sSFGxU83d3M3TBFUg04GvOKolFwGM6S4gRc
# a+cxm3Eiuiu9BlIUeHEQUl6NmVbFZg9T9YwGB+shQEk9a0Lz2Hl1Rvp8lFBLmjEO
# +BX2HrHRw+lIqezoiU1t1ly4D1hpIDCQYPk3fNp+GCCf20ZKZTtRGEr+iu2sjahI
# ISigEYq/iNmMyvavGrdCtguampq07DJ/7Pgo5vK9XKQFWskyg/tEDjfE4SnluCmt
# zv5i8+D3SmihghNKMIITRgYKKwYBBAGCNwMDATGCEzYwghMyBgkqhkiG9w0BBwKg
# ghMjMIITHwIBAzEPMA0GCWCGSAFlAwQCAQUAMIIBPQYLKoZIhvcNAQkQAQSgggEs
# BIIBKDCCASQCAQEGCisGAQQBhFkKAwEwMTANBglghkgBZQMEAgEFAAQgsNKPC80r
# e4Un8KUAazEU+oRHcLoP6INmlGTJ+bgRPYcCBlivZa03PRgTMjAxNzAzMDkxODQz
# MTkuMTI4WjAHAgEBgAIB9KCBuaSBtjCBszELMAkGA1UEBhMCVVMxEzARBgNVBAgT
# Cldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29m
# dCBDb3Jwb3JhdGlvbjENMAsGA1UECxMETU9QUjEnMCUGA1UECxMebkNpcGhlciBE
# U0UgRVNOOjk4RkQtQzYxRS1FNjQxMSUwIwYDVQQDExxNaWNyb3NvZnQgVGltZS1T
# dGFtcCBTZXJ2aWNloIIOzTCCBnEwggRZoAMCAQICCmEJgSoAAAAAAAIwDQYJKoZI
# hvcNAQELBQAwgYgxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAw
# DgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24x
# MjAwBgNVBAMTKU1pY3Jvc29mdCBSb290IENlcnRpZmljYXRlIEF1dGhvcml0eSAy
# MDEwMB4XDTEwMDcwMTIxMzY1NVoXDTI1MDcwMTIxNDY1NVowfDELMAkGA1UEBhMC
# VVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNV
# BAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRp
# bWUtU3RhbXAgUENBIDIwMTAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
# AQCpHQ28dxGKOiDs/BOX9fp/aZRrdFQQ1aUKAIKF++18aEssX8XD5WHCdrc+Zitb
# 8BVTJwQxH0EbGpUdzgkTjnxhMFmxMEQP8WCIhFRDDNdNuDgIs0Ldk6zWczBXJoKj
# RQ3Q6vVHgc2/JGAyWGBG8lhHhjKEHnRhZ5FfgVSxz5NMksHEpl3RYRNuKMYa+YaA
# u99h/EbBJx0kZxJyGiGKr0tkiVBisV39dx898Fd1rL2KQk1AUdEPnAY+Z3/1ZsAD
# lkR+79BL/W7lmsqxqPJ6Kgox8NpOBpG2iAg16HgcsOmZzTznL0S6p/TcZL2kAcEg
# CZN4zfy8wMlEXV4WnAEFTyJNAgMBAAGjggHmMIIB4jAQBgkrBgEEAYI3FQEEAwIB
# ADAdBgNVHQ4EFgQU1WM6XIoxkPNDe3xGG8UzaFqFbVUwGQYJKwYBBAGCNxQCBAwe
# CgBTAHUAYgBDAEEwCwYDVR0PBAQDAgGGMA8GA1UdEwEB/wQFMAMBAf8wHwYDVR0j
# BBgwFoAU1fZWy4/oolxiaNE9lJBb186aGMQwVgYDVR0fBE8wTTBLoEmgR4ZFaHR0
# cDovL2NybC5taWNyb3NvZnQuY29tL3BraS9jcmwvcHJvZHVjdHMvTWljUm9vQ2Vy
# QXV0XzIwMTAtMDYtMjMuY3JsMFoGCCsGAQUFBwEBBE4wTDBKBggrBgEFBQcwAoY+
# aHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraS9jZXJ0cy9NaWNSb29DZXJBdXRf
# MjAxMC0wNi0yMy5jcnQwgaAGA1UdIAEB/wSBlTCBkjCBjwYJKwYBBAGCNy4DMIGB
# MD0GCCsGAQUFBwIBFjFodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vUEtJL2RvY3Mv
# Q1BTL2RlZmF1bHQuaHRtMEAGCCsGAQUFBwICMDQeMiAdAEwAZQBnAGEAbABfAFAA
# bwBsAGkAYwB5AF8AUwB0AGEAdABlAG0AZQBuAHQALiAdMA0GCSqGSIb3DQEBCwUA
# A4ICAQAH5ohRDeLG4Jg/gXEDPZ2joSFvs+umzPUxvs8F4qn++ldtGTCzwsVmyWrf
# 9efweL3HqJ4l4/m87WtUVwgrUYJEEvu5U4zM9GASinbMQEBBm9xcF/9c+V4XNZgk
# Vkt070IQyK+/f8Z/8jd9Wj8c8pl5SpFSAK84Dxf1L3mBZdmptWvkx872ynoAb0sw
# RCQiPM/tA6WWj1kpvLb9BOFwnzJKJ/1Vry/+tuWOM7tiX5rbV0Dp8c6ZZpCM/2pi
# f93FSguRJuI57BlKcWOdeyFtw5yjojz6f32WapB4pm3S4Zz5Hfw42JT0xqUKloak
# vZ4argRCg7i1gJsiOCC1JeVk7Pf0v35jWSUPei45V3aicaoGig+JFrphpxHLmtgO
# R5qAxdDNp9DvfYPw4TtxCd9ddJgiCGHasFAeb73x4QDf5zEHpJM692VHeOj4qEir
# 995yfmFrb3epgcunCaw5u+zGy9iCtHLNHfS4hQEegPsbiSpUObJb2sgNVZl6h3M7
# COaYLeqN4DMuEin1wC9UJyH3yKxO2ii4sanblrKnQqLJzxlBTeCG+SqaoxFmMNO7
# dDJL32N79ZmKLxvHIa9Zta7cRDyXUHHXodLFVeNp3lfB0d4wwP3M5k37Db9dT+md
# Hhk4L7zPWAUu7w2gUDXa7wknHNWzfjUeCLraNtvTX4/edIhJEjCCBNowggPCoAMC
# AQICEzMAAACdIJxWd1XUKJoAAAAAAJ0wDQYJKoZIhvcNAQELBQAwfDELMAkGA1UE
# BhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAc
# BgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEmMCQGA1UEAxMdTWljcm9zb2Z0
# IFRpbWUtU3RhbXAgUENBIDIwMTAwHhcNMTYwOTA3MTc1NjQxWhcNMTgwOTA3MTc1
# NjQxWjCBszELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNV
# BAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjENMAsG
# A1UECxMETU9QUjEnMCUGA1UECxMebkNpcGhlciBEU0UgRVNOOjk4RkQtQzYxRS1F
# NjQxMSUwIwYDVQQDExxNaWNyb3NvZnQgVGltZS1TdGFtcCBTZXJ2aWNlMIIBIjAN
# BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0kSYnBFaKhouqp9TXW1dvLZZdpHA
# JlsD5shsX6Mq60wARnQ4FL8qeF2wI0zsbmBI7EnkW3WmcP3z1K5Vbo69BB9nPRn9
# MXKClKFzsS688BzU2+8huMaptMbCRgcumcw+IQvDLkjfDGp1xTWO11mcqztIfp6y
# 4PxUlt4TRzlC0G7WS/2/DKTwC+X66MiIi+6c+3XhxEvoyw5kzlfeYKh6Ss5lHLhl
# liNiO38FT1lm3ekN1fh8vsBM3nsKlhvMVTkEbwYIQTi79RnftXoEdwUc4uyMx/Gx
# ml5HbsyyHqPalniB7vAHmIBRvroKFB5+njpZJKFXcwz+QUROlsJUUQ+pxQIDAQAB
# o4IBGzCCARcwHQYDVR0OBBYEFLyGCMpbalrK5L3My4K0FUjqh+WhMB8GA1UdIwQY
# MBaAFNVjOlyKMZDzQ3t8RhvFM2hahW1VMFYGA1UdHwRPME0wS6BJoEeGRWh0dHA6
# Ly9jcmwubWljcm9zb2Z0LmNvbS9wa2kvY3JsL3Byb2R1Y3RzL01pY1RpbVN0YVBD
# QV8yMDEwLTA3LTAxLmNybDBaBggrBgEFBQcBAQROMEwwSgYIKwYBBQUHMAKGPmh0
# dHA6Ly93d3cubWljcm9zb2Z0LmNvbS9wa2kvY2VydHMvTWljVGltU3RhUENBXzIw
# MTAtMDctMDEuY3J0MAwGA1UdEwEB/wQCMAAwEwYDVR0lBAwwCgYIKwYBBQUHAwgw
# DQYJKoZIhvcNAQELBQADggEBAH/eJCG9We+01otxylmRvi6oRoK7j99kHX3mKgu8
# KGdL/vl3v7X0TqT96EoPPmcis1aJbZcIWuwjFPV5KhNXjJIXnQYh6vOo6hs73NuE
# mkv3chX2n48nqP+l4tYgiZVNQKkVYF65lwHXMAv/QmprVtnsWlw2A4DMFi1qwbkz
# ZE/bXmt/2G/AroGlOO06zl1yGoxMFctfk4yy3aoALeP9ZCipqb4QHf4V3CePH46k
# A+qON9sEJVMf4TJ69zsikMzcKg3BXoYJ1T5W76sloHrLMkBY9r0JW7bJ/3tHeXSG
# pYad2CINV17hqA3GJk4C9v069gGs95e8uZEOYdud0++mNmmhggN2MIICXgIBATCB
# 46GBuaSBtjCBszELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAO
# BgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEN
# MAsGA1UECxMETU9QUjEnMCUGA1UECxMebkNpcGhlciBEU0UgRVNOOjk4RkQtQzYx
# RS1FNjQxMSUwIwYDVQQDExxNaWNyb3NvZnQgVGltZS1TdGFtcCBTZXJ2aWNloiUK
# AQEwCQYFKw4DAhoFAAMVABgNrLOMaDCz+HQZsnjOgCs1Lwj6oIHCMIG/pIG8MIG5
# MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVk
# bW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMQ0wCwYDVQQLEwRN
# T1BSMScwJQYDVQQLEx5uQ2lwaGVyIE5UUyBFU046NERFOS0wQzVFLTNFMDkxKzAp
# BgNVBAMTIk1pY3Jvc29mdCBUaW1lIFNvdXJjZSBNYXN0ZXIgQ2xvY2swDQYJKoZI
# hvcNAQEFBQACBQDcbAe8MCIYDzIwMTcwMzA5MTY1NjI4WhgPMjAxNzAzMTAxNjU2
# MjhaMHQwOgYKKwYBBAGEWQoEATEsMCowCgIFANxsB7wCAQAwBwIBAAICIRkwBwIB
# AAICGXEwCgIFANxtWTwCAQAwNgYKKwYBBAGEWQoEAjEoMCYwDAYKKwYBBAGEWQoD
# AaAKMAgCAQACAxbjYKEKMAgCAQACAwehIDANBgkqhkiG9w0BAQUFAAOCAQEAfPMD
# tYrzSNrWGa+al+TnW30QAKY5/YywXrB0Rta8ChTdI9pXKdNjG/3u+DsMX0EWziTS
# dKpI4Kn1PNz/NZJyO1OsYx0SyWiU0LchRCb/aHBI+AyzdAHo1LfLUAV6uuPW2H5q
# 9s9eX3prtHfiki5z0ZMTbbVxCtcrAwm41+cTydYem/qygxkiYIL9bpkaIIxPsLz5
# R9Y/mBu0QS3DRmlMsoBzT7ena8GMJmggZM1FpAcp0YNgUYehNSMvO3OPj11ZKEjy
# YLfFoCOsJn1yXim3rSuL7RYmCkaaV22gAJXXapD8TFhi6yde1XrKDdSrzHs3FUV6
# hkZaEA/zTCC8xCjkwzGCAvUwggLxAgEBMIGTMHwxCzAJBgNVBAYTAlVTMRMwEQYD
# VQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24xJjAkBgNVBAMTHU1pY3Jvc29mdCBUaW1lLVN0YW1w
# IFBDQSAyMDEwAhMzAAAAnSCcVndV1CiaAAAAAACdMA0GCWCGSAFlAwQCAQUAoIIB
# MjAaBgkqhkiG9w0BCQMxDQYLKoZIhvcNAQkQAQQwLwYJKoZIhvcNAQkEMSIEIHKP
# 1TAvZ3Vq7MnYzVUPKeGkImxeXgZimYgQuw5Bj4OqMIHiBgsqhkiG9w0BCRACDDGB
# 0jCBzzCBzDCBsQQUGA2ss4xoMLP4dBmyeM6AKzUvCPowgZgwgYCkfjB8MQswCQYD
# VQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEe
# MBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYDVQQDEx1NaWNyb3Nv
# ZnQgVGltZS1TdGFtcCBQQ0EgMjAxMAITMwAAAJ0gnFZ3VdQomgAAAAAAnTAWBBRG
# QG+XtGuik+GrDlPLXmpIREWmSjANBgkqhkiG9w0BAQsFAASCAQAJJ0jjC6dDqnoO
# 2UNB3rZ60SBEMuwd2OsBPjz/zbNxqfkOh9dGD0CrECKg2QpdgEx0U5xcXHcGtqTP
# Yrb2zkbFMR+vIcMUjF+RQNqh4U9lLJSVDDVpgOhwi2ChAc00yWXWi+XVQMHqmujH
# +7ZwEbnF9Noi34VeW+AzH0wi35s1m/uBes8cTYlIYMlE4ORxvz87HTHPFTpCGbxs
# SPwR9dwEXF6hK4uSrGe+4UVNMWpQqrcy9813yjYXH/Ut8RW9xHpzHaF78xjCUlON
# 3SA9jIdA+OtC8ZRu9aHuQROWb5OsWiWBjfiIWn1fwrAUk4OWZoD5WSeITQqzhqNW
# EqENXFN1
# SIG # End signature block