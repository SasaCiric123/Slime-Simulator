# Project State

- Gotovo: Rojo + VS Code + Studio povezani, Gemini CLI, GEMINI.md, src/shared sa Config/Slimes.luau, reorganizacija na src/server i src/client, implementiran starter slime koji prati igrača (SlimeService.luau i Main.server.luau).
- U toku: Faza 1 (jezgro).
- Struktura: src/server/Main.server.luau, src/server/SlimeService.luau, src/client/Main.client.luau, src/shared/Config/Slimes.luau; u Studiju ručno: Workspace (mapa) i ReplicatedStorage/ClickEvent.
- Odluke: slimeovi automatski napadaju najbližeg NPC-a, igrač klikom isključuje/uključuje auto-napad; privremeno bez DataStore-a (dolazi u Fazi 2); privremeni Part za slime označen sa `-- TODO`.
- Sledeći korak: NPC slimeovi koji gmižu po zoni.
