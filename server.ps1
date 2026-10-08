$port = 5500
$root = $PSScriptRoot
if (-not $root) { $root = (Get-Location).Path }

$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$port/")
$listener.Start()

Write-Host "Jaipur Prime Property Server running at http://localhost:$port/"

$mimeTypes = @{
    ".html" = "text/html; charset=utf-8"
    ".css"  = "text/css; charset=utf-8"
    ".js"   = "application/javascript; charset=utf-8"
    ".json" = "application/json; charset=utf-8"
    ".pdf"  = "application/pdf"
    ".svg"  = "image/svg+xml"
    ".png"  = "image/png"
    ".jpg"  = "image/jpeg"
    ".jpeg" = "image/jpeg"
    ".ico"  = "image/x-icon"
}

try {
    while ($listener.IsListening) {
        try {
            $context = $listener.GetContext()
            $request = $context.Request
            $response = $context.Response

            $urlPath = $request.Url.LocalPath.TrimStart('/')
            if ([string]::IsNullOrWhiteSpace($urlPath)) {
                $urlPath = "index.html"
            }

            # Normalize slashes for Windows path
            $urlPath = $urlPath.Replace('/', [System.IO.Path]::DirectorySeparatorChar)
            $filePath = Join-Path $root $urlPath

            $response.AddHeader("Access-Control-Allow-Origin", "*")
            $response.AddHeader("Access-Control-Allow-Methods", "GET, POST, PUT, OPTIONS, HEAD")
            $response.AddHeader("Access-Control-Allow-Headers", "Content-Type, Authorization")
            $response.AddHeader("Cache-Control", "no-cache, no-store, must-revalidate, max-age=0")
            $response.AddHeader("Pragma", "no-cache")
            $response.AddHeader("Expires", "0")

            if ($request.HttpMethod -eq "OPTIONS") {
                $response.StatusCode = 200
                $response.OutputStream.Close()
                continue
            }

            # Direct API to save site data on localhost
            if (($request.HttpMethod -eq "POST" -or $request.HttpMethod -eq "PUT") -and ($urlPath -eq "api\save-site-data" -or $urlPath -eq "assets\data\site-data.json")) {
                $reader = New-Object System.IO.StreamReader($request.InputStream, [System.Text.Encoding]::UTF8)
                $body = $reader.ReadToEnd()
                $savePath = Join-Path $root "assets\data\site-data.json"
                [System.IO.File]::WriteAllText($savePath, $body, [System.Text.Encoding]::UTF8)
                
                $response.StatusCode = 200
                $response.ContentType = "application/json; charset=utf-8"
                $resBytes = [System.Text.Encoding]::UTF8.GetBytes('{"success":true,"message":"Local site-data.json updated instantly!"}')
                $response.ContentLength64 = $resBytes.Length
                $response.OutputStream.Write($resBytes, 0, $resBytes.Length)
                $response.OutputStream.Close()
                continue
            }

            if (Test-Path $filePath -PathType Leaf) {
                $ext = [System.IO.Path]::GetExtension($filePath).ToLower()
                $contentType = if ($mimeTypes.ContainsKey($ext)) { $mimeTypes[$ext] } else { "application/octet-stream" }
                $response.ContentType = $contentType

                $bytes = [System.IO.File]::ReadAllBytes($filePath)
                $response.ContentLength64 = $bytes.Length

                if ($request.HttpMethod -ne "HEAD") {
                    $response.OutputStream.Write($bytes, 0, $bytes.Length)
                }
            } else {
                $response.StatusCode = 404
                $msg = [System.Text.Encoding]::UTF8.GetBytes("404 Not Found")
                $response.ContentLength64 = $msg.Length
                if ($request.HttpMethod -ne "HEAD") {
                    $response.OutputStream.Write($msg, 0, $msg.Length)
                }
            }

            $response.OutputStream.Close()
        } catch {
            # Catch per-request errors without stopping server
        }
    }
} finally {
    $listener.Stop()
}
