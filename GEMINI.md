# Gemini CLI & Workspace Instructions

## Pravila
- Na kraju svakog završenog zadatka ažuriraj PROJECT_STATE.md (Gotovo, U toku, Struktura, Sledeći korak) i javi mi šta si upisao.
- Struktura projekta je src/server, src/client, src/shared. Skripte se zovu Main.server.luau i Main.client.luau.
- U Studiju postoje stvari koje Rojo ne prati: Workspace (mapa) i ReplicatedStorage/ClickEvent. Ne pokušavaj da ih menjaš preko default.project.json.
- Ignoriši ServerStorage/ZeroScript, to nije deo ovog projekta.
- Privremena rešenja (Part umesto modela, leaderstats umesto DataStore) su namerna; označi ih komentarom "-- TODO".

## Trenutna faza
Faza 1: jezgro. Starter slime prati igrača, NPC slimeovi gmižu po zoni, slime automatski napada najbližeg NPC-a, igrač klikom uključuje/isključuje auto-napad, pare od ubistava.
