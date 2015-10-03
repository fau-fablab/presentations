<!doctype html>
<html lang="de">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=1024" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <title>FAU FabLab @ Mathe Rep.</title>
    <meta name="description" content="Präsentation zur Begrüßung der neuen Erstis im Mathe Repetitorium" />
    <meta name="author" content="Sebastian Endres" />
    <link href="http://fonts.googleapis.com/css?family=Open+Sans:regular,semibold,italic,italicsemibold|PT+Sans:400,700,400italic,700italic|PT+Serif:400,700,400italic,700italic" rel="stylesheet" />
<!------------------------------------------------------------------------------------
          A HTML/CSS/JS Presentation for the 21st century using impress.js
Use the arrow keys or tab on the left or the right side of the screen on touch devices
------------------------------------------------------------------------------------->

    <!--TODO: change the style-->
    <link href="impress.js/css/impress-demo.css" rel="stylesheet" />
    
    <link rel="shortcut icon" href="img/logo/fab_cube.png" />
    <link rel="apple-touch-icon" href="img/logo/fab_cube.png" />
  </head>

  <body class="impress-not-supported">

    <!-- this fallback message is only visible when there is `impress-not-supported` class on body. -->
    <div class="fallback-message">
      <p>Your browser <b>doesn't support the features required</b> by <a href="https://github.com/impress/impress.js">impress.js</a>, so you are presented with a simplified version of this presentation.</p>
    </div>

    <div id="impress">

<!---
Available data attributes:
data-x:     move x position of center to position
data-y:     move y position of center to position
data-z:     move z position of content (e.g. in the background)
data-scale: scale content
data-rotate: rotate content
data-rotate-x: 3D rotating around the x axis
data-rotate-y: 3D rotating around the y axis
data-rotate-z: 3D rotating around the z axis

slides get the class="future" / "present" / "past" dynamically by impress.js -> animations? :D
-->

<!-- Einleitung
=============== -->
        <div id="start" class="step slide" data-x="-1000" data-y="-1500">
          <q>Noch eine Gruppe?</q>
          <img class="title-img" src="img/logo/logo.svg" alt="FAU FabLab">
        </div>

        <div id="title" class="step slide" data-x="0" data-y="-1500">
          <q>FabLab?</q>
          <h1>Offene Werkstatt</h1>
          <p><b>Weltweit</b> über 400</p>
          <p>Ideen und Wissen miteinander teilen</p>
        </div>

        <div id="about_fablab" class="step slide" data-x="1000" data-y="-1500">
          <ul>
            <li>Offene <b>Hightech-Wekstatt</b> an der TechFak</li>
            <li>Von Studenten, <b>für jeden</b></li>
            <li><b>Selbständig</b> Ideen verwirklichen</li>
            <li>lernen, wie's geht</li>
            <li>Zum <b>Selbstkostenpreis</b></li>
          </ul>
        </div>

<!-- Maschinen
============== -->
        <div id="lazorkutter" class="step slide" data-x="0" data-y="0" data-scale="4">
          <q>Hightech?</q>
          <h1>Lasercutter</h1>
          <ul>
            <li>Schneidet und graviert</li>
            <li>Acryl, Holz, Aluminium, FAU Cards</li>
          </ul>
          <p>TODO: Bilder hier einfügen</p>
        </div>

        <div id="3ddrucker" class="step" data-x="0" data-y="0" data-scale="4">
          <q>Hightech?</q>
          <h1>3D Drucker</h1>
          <p>Rapid Prototyping zum Zuschauen</p>
          <p>TODO: Bilder / (Video?) hier einfügen</p>
        </div>

        <div id="schneideplotter" class="step" data-x="0" data-y="0" data-scale="4">
          <q>Hightech?</q>
          <h1>Schneideplotter, T-Shirts</h1>
          <p>TODO: Bilder und Text hier einfügen</p>
        </div>

        <div id="cnc" class="step" data-x="0" data-y="0" data-scale="4">
          <q>Hightech?</q>
          <h1>CNC Fräse und Drehbank</h1>
          <p>Zerpant Alu, Holz, Stahl</p>
          <p>TODO: Bilder und Text hier einfügen</p>
        </div>

        <div id="ewerkstatt" class="step" data-x="0" data-y="0" data-scale="4">
          <q>Hightech?</q>
          <h1>E-Werkstatt</h1>
          <p>Multimeter, Lötkolben, Oszis, ...</p>
          <p>Widerstände, Kondensatoren, Transistoren, ...</p>
          <p>Für E-Techniker und solche die es werden wollen</p>
          <p>TODO alternativ: Im Gegensatz zu GET auch mal was praktisches oder so...</p>
          <p>TODO: Bilder hier einfügen</p>
        </div>

        <div id="andere_tools" class="step" data-x="0" data-y="0" data-scale="4">
          <q>Hightech?</q>
          <h1>...und jede Menge Anderes</h1>
          <p>Druckluft</p>
          <p>TODO: ewig lange liste?</p>
          <p>TODO: Bilder und Text hier einfügen</p>
        </div>

<!-- Infos Schlag auf Schlag
============================ -->

        <div id="wo" class="step">
          <q>Wo?</q>
          <p>Hinter den Hörsäälen</p>
          <img class="foobar" src="images/fablab_door.png" alt="FabLab Türe" />
        </div>

        <div id="wann" class="step">
          <q>Wann?</q>
          <h2>OpenLabs</h2>
          <p>Bald wieder <b>regelmäßige Öffnungszeiten</b> mit Einweisungen und freundlichem Personal</p>
        </div>

        <div id="warumich" class="step">
          <q>Warum ich?</p>
          <h2>Du solltest vorbei kommen, wenn...</h2>
          <ul>
            <li>Du mal schauen willst, was das FabLab jetzt eigentlich ist</li>
            <li>Du Ideen/Projekte hast, aber nicht das Werkzeug</li>
            <li>Du mitmachen willst</li>
            <li>Du gerade Langeweile zwischen den Vorlesungen hast <small>- oder dann besser nicht</small></li>
          </ul>
        </div>

        <div id="links" class="step">
          <h2><a href="https://fablab.fau.de"><pre>https://fablab.fau.de</pre></a></h2>
          <img id="qrcode" class="qrcode" src="images/qrcode_website.png" alt="Hier könnte ihr QR-Code stehen">
        </div>

        <div id="overview" class="step" data-x="3000" data-y="1500" data-scale="10">
        </div>

    </div>


    <!-- TODO: minify js -->
    <script src="impress.js/js/impress.js"></script>
    <script>impress().init();</script>

  </body>
</html>
