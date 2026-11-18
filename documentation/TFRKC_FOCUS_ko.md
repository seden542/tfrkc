# TFRKC 내전 국가중점 제작 기록 — 2026-11-16

실제 적용 위치: `C:/Users/L/Documents/Paradox Interactive/Hearts of Iron IV/mod/tfrkc`

## 확인된 원본과 이번 창작의 구분

**원본에서 확인:** TFRKC·TFRKP(3617039195)·TFR(3350890356) 세 경로 모두 접근했습니다. Workshop은 읽기만 했습니다. TFRKC에는 공통 중점 TFRKC_wartime_administration 1개, TFRKC_civilwar_tree, 7세력별 초기 약점, 해군·개입군 기능, 실제 TFRKC_INTERFACE.md/JSON이 있었습니다. 기존 364개 텍스트·설정 파일은 SHA-256 비교로 보존했습니다. 날짜·영토·인물·장편 사건·부대 편제 파일은 수정하지 않았습니다.

TFRKP common/national_focus/TFR_national_focus_KOR.txt에는 cost 1·2·3·5 중점이 흔하고, 군정 진입 중점 KOR_lee_army_route_common_focus_1은 cost=3, 정치력 50·안정도 0.15와 기존 군정 국민정신 등을 제공합니다. 설치 게임 common/defines/00_defines.lua의 FOCUS_POINT_DAYS=7이며 TFR에는 이를 바꾸는 정의를 찾지 못했습니다. 기존 계엄 선포 KOR_yoon_open_dream은 cost=1.46이고 원본 미션과 korea.148을 select_effect에서 호출합니다. 본 제작은 이 중점·준비도 디시전을 복제하지 않았습니다.

TFRKP 인물 정의 KOR_nam_young_sin_char는 army_chief 조언가 및 skill=4 field_marshal, organizer/career_officer/organisational_leader 특성을 가집니다. 한국어 현지화의 이력은 학군 23기·동아대학교 교육학과·3사단장·특전사령관·군사안보지원사령관·지상작전사령관·육군참모총장입니다. 원본 KOR_lee_army_route_common_focus_10_desc는 남영신 온건파와 강경파의 긴장을 묘사합니다. 원본의 별도 대통령 암살 경로와 공산 정권 수립 서사는 이번 윤석열 패전·전주 분기에 가져오지 않았습니다.

실제로 참고한 번역: localisation/korean/replace/00 TFRKP Main l_korean.yml의 KOR_yoon_open_dream_desc, KOR_lee_army_route_common_focus_1_desc·10_desc와 TFRKP_military_supreme_council_l_korean.yml. 원본의 색상 문법만 따르며 문장을 복제하지 않았습니다.

**이번 제작의 창작:** 아래 112개 신규 중점, 30개 국민정신, 1개 외교 의견 수정치, 분기 보상과 모든 신규 한국어 문안입니다. 실존 인물을 추가하지 않았으며 기존 지도자를 교체하지 않습니다. 민족정화전선의 붉은 문장은 가해 정권의 선전·자기기만으로 명시했습니다. 청소년해방군 병력은 성인으로만 서술했습니다.

**미검증:** 실제 전투 균형, AI 장기 선택, 저장/불러오기, 엔진의 일일 전환·취소 처리 및 게임 중점 화면. 런타임 시도 기록은 아래 별도 구분합니다.

## 실제 추가 파일

모두 중점 담당 전용 신규 파일입니다. 기존 공용 트리·사건·아이디어 파일을 덮어쓰지 않았습니다. 같은 내용은 작업공간 src에 함께 보관했습니다.

- `common/opinion_modifiers/TFRKC_focus_opinions.txt`
- `common/scripted_triggers/TFRKC_focus_runtime.txt`
- `common/national_focus/TFRKC_focus_KOR.txt`
- `common/national_focus/TFRKC_focus_KCH.txt`
- `common/national_focus/TFRKC_focus_KYA.txt`
- `common/national_focus/TFRKC_focus_KRC.txt`
- `common/national_focus/TFRKC_focus_KLF.txt`
- `common/national_focus/TFRKC_focus_KWC.txt`
- `common/national_focus/TFRKC_focus_KSF.txt`
- `common/national_focus/TFRKC_focus_KNM.txt`
- `common/national_focus/TFRKC_focus_KPL.txt`
- `common/national_focus/TFRKC_focus_POST.txt`
- `common/ideas/TFRKC_focus_ideas.txt`
- `common/scripted_effects/TFRKC_focus_runtime.txt`
- `common/on_actions/TFRKC_focus_runtime.txt`
- `localisation/korean/TFRKC_focus_l_korean.yml`
- `documentation/TFRKC_FOCUS_IDS.json`
- `documentation/TFRKC_FOCUS_ko.md`
- `documentation/validation-focus.json`

작업공간 보조 도구: tools/focus-data.cjs, build-focus.cjs, validate-focus.cjs, render-focus.ps1, document-focus.cjs. docs/focus-layout에는 원본 아이콘으로 그린 배치 미리보기 10장이 있습니다. 이것은 실제 게임 스크린샷이 아닙니다.

## 규모·기간·보상

| 세력 | 트리 ID | 중점 수 | 주요 분기 |
|---|---|---:|---|
| 대한민국 정부 | `TFRKC_focus_KOR_tree` | 18 | 민생·잔류군 재편 / 감사 행정 ↔ 긴급예산 / PDTO·NATO 개별 연락 / 헌정수호연합 연락 |
| 헌정수호연합 | `TFRKC_focus_KCH_tree` | 14 | 전방·후방 교대 / 민간 감사 ↔ 작전권 유보 / 전후 헌정복원 조건 |
| 국가수호위원회·윤어게인 | `TFRKC_focus_KYA_tree` | 14 | 윤석열 직접 지휘 / 대통령 충성파 ↔ 종교적 구국파·성인 청년 강경파 / 경상 생산 |
| 국가재건최고회의 | `TFRKC_focus_KRC_tree` | 14 | 기동부대·정비 / 남영신 재건 노선 ↔ 강경 군정 / 기술관료 |
| 청소년해방군 | `TFRKC_focus_KLF_tree` | 14 | 성인 의용군 / 학생자치·교육·주거·노동 / 합의 개혁 ↔ 즉각 개혁 |
| 전국노동자평의회 | `TFRKC_focus_KWC_tree` | 14 | 생산·전력·식량 / 작업장 거부권 ↔ 중앙 배정 / 조건부 외부 지원 논쟁 |
| 민족정화전선 | `TFRKC_focus_KSF_tree` | 14 | 무장조직·강압 통제 / 배제 확대 ↔ 실무 예외 / 인력·산업·민심·외교 손실 |
| 해군 중립사령부 | `TFRKC_focus_KNM_tree` | 4 | 구조·구호·안전 정비·통합용 장부 |
| 대한인민해방군 | `TFRKC_focus_KPL_tree` | 4 | 이미 파견된 부대의 연락·민간 수송·기존 공동 승리 협의 |
| 통일 이후 확장 기반 | `TFRKC_focus_POST_tree` | 2 | 행정 목록·평시 창구 2개만 제공, 장기 정치 노선은 후속 확장 |

전투 7세력은 정부 18개, 나머지 각 14개입니다. 배타 분기 때문에 일반 세력은 한 회차에 12개를 완료할 수 있습니다. 해군·개입군 각 4개와 전후 2개는 별도입니다. 공통 조상은 7일, 긴급 민생·점호 7일, 조직 정비·수송 14일, 노선 확정·제도 정비 21일을 사용합니다. 전후 마지막 중점만 35일입니다. 일반 세력이 선택 가능한 12개를 모두 마치는 기본 합계는 175일이며, 생존 기능은 시작 직후 두 갈래에서 선택할 수 있습니다. 모든 중점 완료는 개전·통일의 필수 조건이 아닙니다.

정부는 총 600명만 보충하며 공장·장비·부대·외국군을 무료 생성하지 않습니다. 다른 세력의 직접 보충도 700~900명 이내이고 전차·함정 생성은 없습니다. 정부 생산 보상은 정비 +2%, 긴급예산 선택 시 추가 +4% 수준입니다. 기존 행정 혼란을 제거하는 75정치력·30일 디시전은 그대로 두고 중점은 비용 확보만 돕습니다. 디시전의 30일은 기존 행정 사업 기간이며 개전 날짜 계산과 무관합니다.

초기 약점 완화는 해당 기존 국민정신을 보유할 때만 swap_ideas로 한 번 교체합니다. 예: 헌정수호의 조직력 -10%/보급 +10% → -6%/+6%, 윤어게인 조직력 -12%/회복 -8% → -7%/-4%, 최고회의 연료 -20%/보급 +15% → -12%/+8%, 청년 조직력 -15%/훈련 +15% → -8%/+8%, 평의회 조직력 -18% → -11%(핵심영토 방어 +10% 유지), 전선 조직력 -20%/정치력 -0.25 → -12%/-0.15. 제거된 약점을 중점이 다시 붙이지 않습니다.

여러 세력에 같은 강한 보너스를 복제하지 않았습니다. 생산·통제·민간 감사의 대가는 국민정신에 함께 적었습니다. 민족정화전선 배제 노선은 공격 +4% 대신 충원계수 -8%, 생산 -7%, 안정도 -5%를 추가로 부담합니다. 강압 통제는 별도로 생산 -5%/안정도 -3%이며, 고립 중점은 생존 일본·독일·영국·중국이 전선을 보는 의견 -20을 부여합니다. 이 의견 손실은 전후에도 남는 평판 비용으로, 전시 전용 국민정신과 구분합니다.

원본 TFRKP의 패전·경제·정치 국민정신과 동적 수정치는 삭제하거나 덮어쓰지 않습니다. 정부가 원본에서 물려받는 패전 국민정신 등과 신규 보상의 중첩 가능성을 조사했으며 신규 보상은 작게 제한했습니다. 모든 원본 경제/사회 변수 상태에서의 실전 중첩 균형까지 검증한 것은 아닙니다.

## 할당·전환·완료 기록

기존 영토 선분할 효과가 아직 공용 TFRKC_civilwar_tree를 명시적으로 불러오므로, 이를 보존하고 중점 전용 on_daily → TFRKC_focus_dispatch_effect로 다음 일일 틱에 국가별 트리를 배정합니다. 최대 약 하루 동안 기존 공용 화면이 보일 수 있습니다. 각 국가 트리의 선택 가중치 1000은 원본 KOR 20/기존 공용 100보다 높지만, 태그와 분할 참가 플래그가 맞아야만 적용됩니다. 시작 시 대한민국은 원본 트리를 유지합니다. 해군은 중립 플래그, 개입군은 실제 개입 후 참가 플래그가 있어야 전환합니다.

분할 준비 중에는 신규 트리가 표시되어도 전시 중점을 실행할 수 없습니다. 실제 기존 TFRKC_civilwar_active 이후에만 실행됩니다. 별도 30일·고정 개전일·달력 조회·선전포고를 만들지 않았습니다. on_daily는 트리 배정과 전후 정리만 하며 has_focus_tree 조건으로 반복 초기화를 막습니다.

전시 중점은 exists=yes, active, finished 부재, 비항복, 최소 하나의 본인 소유·통제 주를 요구합니다. available와 completion_reward 내부에 같은 조건을 적용하고 cancel_if_invalid=yes / continue_if_invalid=no로 두었습니다. 강제 완료 명령을 쓰더라도 종료·항복 조건을 벗어나면 보상은 지급되지 않습니다. 고정 주·수도에 공장을 주는 보상이 없어서 수도나 특정 산업지역을 잃어도 엉뚱한 소유자에게 보상이 들어가지 않습니다.

각 완료는 <중점 ID>_done 국가 플래그로 보존합니다. load_focus_tree의 keep_completed=yes는 새 트리에 같은 ID가 있을 때만 보존하는 엔진 의미입니다. 이번 트리는 전전·전시·전후의 중점 ID가 달라 완료 목록을 억지로 복제하지 않습니다. 원본 KOR 완료 항목은 기존 선분할 코드가 공용 트리를 불러올 때 이미 다른 트리로 전환하며, 본 구현은 이를 소급 복구하거나 보상 재지급하지 않습니다. 기존 공용 중점을 완료한 구 저장은 TFRKC_focus_legacy_administration_done으로 기록만 하고 신규 수습 중점을 자동 완료하지 않습니다.

기존 TFRKC_unify_effect가 finished/unifier를 설정하고 해군을 통합합니다. 다음 일일 틱에 중점 전용 전시 국민정신 30개 및 기존 초기 약점 8개를 정리하고 TFRKC_focus_POST_tree로 전환합니다. 함대 이전·해상 제한 해제·통일 판정은 복제하지 않습니다. 전후 2개는 모두 독립 ID이며 선택했던 분기 완료 플래그는 남습니다. 대규모 후반 트리는 만들지 않았습니다.

## 기존 기능 재사용과 담당별 연결 목록

| 연결 | 실제 기존 구현 | 중점 측 확인 조건·기대 효과 |
|---|---|---|
| 달력 기반 개전 | TFRKC_timeline / TFRKC_calendar / tfrkc.10 | 기존 active/분할 참가 플래그만 읽음. 날짜 예약이나 필수 중점 조건 없음 |
| 정부 행정 복구 | TFRKC_restore_administration | KOR_a3 완료는 정치력 40만 제공. 약점 제거는 기존 디시전 완료가 담당 |
| PDTO 지원 | 개전 7일 뒤 tfrkc_war.1 → 일본 .2 | KOR_pdto_done은 부품 규격 준비의 서사 훅. 실제 지원 재지급·가입·참전 없음 |
| NATO 지원 | tfrkc_war.1 → 독일 .3, 독일-영국 동맹 조건 | KOR_nato_done은 별도 연락 훅. 미국·캐나다 제외. 일본 효과와 합치지 않음 |
| 정부-헌정 공동작전 | 기존 KOR-KCH 동맹 유지 | KOR_joint_done(상대 생존·비항복·동맹·비적대 필요) / KCH_a3_done. 선택적으로 협력 사건 문안에 반영 가능, 병력 이관 없음 |
| 헌정연합 전후 선택 | tfrkc_war.10 → .11 | KCH_pA2_done 또는 pB2_done은 협상 입장 원고용. 통합/전쟁 사건의 필수 조건으로 추가하지 않음 |
| 평의회 지원 논쟁 | tfrkc.20~23 | KWC_pA2_done 또는 pB2_done은 자치/중앙협상 입장. 위기·양국 승인·준비·영토 조건은 기존 담당이 유지. 무한 소환 없음 |
| 평의회·개입군 정리 | tfrkc.50 → .51 | KPL_settlement_done은 협의 자료. 기존 승리/생존 조건 후 통합 선택만 기존 사건이 실행 |
| 해군 통합 | TFRKC_unify_effect | KNM_ledger_done은 장부 준비 기록. 중점 완료 여부와 무관하게 기존 통일 효과가 함대·섬 통합 |
| 전후 확장 | TFRKC_focus_POST_tree | 기존 finished+unifier 확인 후 전환. 선택 노선은 *_done 국가 플래그 사용 |
| 국제전 연결 | tfrkc_war.20 / TFRKC_postwar_connection_ready | 기존 조건을 수정·설정하지 않음. EADI/PDTO 진입은 전쟁 담당 구현 유지 |

위 표의 짧은 KOR_/KCH_ 표기는 모두 TFRKC_focus_ 접두사를 붙인 실제 ID/플래그입니다. 장편 서사 담당은 KYA_pA/pB, KRC_pA/pB, KLF_pA/pB, KWC_pA/pB, KSF_pA/pB의 *_done을 읽어 반응 사건을 쓸 수 있습니다. 현재는 어떤 미존재 사건 ID도 호출하지 않습니다. 신규 디시전은 0개입니다.

**후속 담당에게 필요한 최소 정보:** 선택적 공동지원 효과를 추가할 경우 제공 주체·물자 비용·1회성 여부만 정해 주시면 됩니다. 기존 개전·통일·개입을 진행하는 데 이 답변은 필요하지 않습니다. 전후 장편 분기와 국제전의 새 노선은 이번 범위 밖이며 별도 승인된 설계가 필요합니다.

## 중점별 ID·선행·배타·현지화 목록

각 중점의 제목 키는 ID 그대로, 설명 키는 ID_desc입니다. 완료 플래그는 ID_done입니다. 효과 툴팁은 아래 별도 목록입니다. reward 원문 전체와 조건·좌표·AI 가중치는 동봉 TFRKC_FOCUS_IDS.json에 있습니다. 아래 OR 표기는 같은 prerequisite 블록의 대안이며, 일반 선행 항목끼리는 AND입니다.

### 대한민국 정부 — TFRKC_focus_KOR_tree

| ID / 제목 | 기간 | 선행(AND) | 추가 선행(OR) | 배타 |
|---|---:|---|---|---|
| `TFRKC_focus_KOR_start` / 정부는 여기에 있습니다 | 7일 | 없음 | 없음 | 없음 |
| `TFRKC_focus_KOR_a1` / 내일의 배급표 | 7일 | `TFRKC_focus_KOR_start` | 없음 | 없음 |
| `TFRKC_focus_KOR_a2` / 가로등 아래의 순찰 | 14일 | `TFRKC_focus_KOR_a1` | 없음 | 없음 |
| `TFRKC_focus_KOR_a3` / 도착하는 공문 | 21일 | `TFRKC_focus_KOR_a2` | 없음 | 없음 |
| `TFRKC_focus_KOR_m1` / 남아 있는 지휘관들 | 7일 | `TFRKC_focus_KOR_start` | 없음 | 없음 |
| `TFRKC_focus_KOR_m2` / 다시 쓰는 복무명부 | 14일 | `TFRKC_focus_KOR_m1` | 없음 | 없음 |
| `TFRKC_focus_KOR_m3` / 고쳐 쓰는 국가 | 21일 | `TFRKC_focus_KOR_m2` | 없음 | 없음 |
| `TFRKC_focus_KOR_p1` / 헌법에 남은 빈칸 | 14일 | `TFRKC_focus_KOR_start` | 없음 | 없음 |
| `TFRKC_focus_KOR_pA` / 기록되는 결재 | 21일 | `TFRKC_focus_KOR_p1` | 없음 | `TFRKC_focus_KOR_pB` |
| `TFRKC_focus_KOR_pB` / 한시적 긴급예산 | 21일 | `TFRKC_focus_KOR_p1` | 없음 | `TFRKC_focus_KOR_pA` |
| `TFRKC_focus_KOR_pA2` / 이름을 지우지 않는 장부 | 14일 | `TFRKC_focus_KOR_pA` | 없음 | 없음 |
| `TFRKC_focus_KOR_pB2` / 먼저 보내는 납품서 | 14일 | `TFRKC_focus_KOR_pB` | 없음 | 없음 |
| `TFRKC_focus_KOR_logistics` / 끊어지지 않는 배급선 | 14일 | `TFRKC_focus_KOR_a3`, `TFRKC_focus_KOR_m2` | 없음 | 없음 |
| `TFRKC_focus_KOR_charter` / 다시 국가가 되기까지 | 21일 | `TFRKC_focus_KOR_logistics`, `TFRKC_focus_KOR_m3` | `TFRKC_focus_KOR_pA2` 또는 `TFRKC_focus_KOR_pB2` | 없음 |
| `TFRKC_focus_KOR_diplomacy` / 외교행낭을 지키다 | 14일 | `TFRKC_focus_KOR_start` | 없음 | 없음 |
| `TFRKC_focus_KOR_pdto` / 일본과 맞추는 부품표 | 14일 | `TFRKC_focus_KOR_diplomacy` | 없음 | 없음 |
| `TFRKC_focus_KOR_nato` / 유럽으로 보내는 전문 | 14일 | `TFRKC_focus_KOR_diplomacy` | 없음 | 없음 |
| `TFRKC_focus_KOR_joint` / 별개의 지휘부, 같은 전선 | 14일 | `TFRKC_focus_KOR_pdto`, `TFRKC_focus_KOR_nato` | 없음 | 없음 |

### 헌정수호연합 — TFRKC_focus_KCH_tree

| ID / 제목 | 기간 | 선행(AND) | 추가 선행(OR) | 배타 |
|---|---:|---|---|---|
| `TFRKC_focus_KCH_start` / 총구 앞의 헌법 | 7일 | 없음 | 없음 | 없음 |
| `TFRKC_focus_KCH_a1` / 초당적 연락망 | 7일 | `TFRKC_focus_KCH_start` | 없음 | 없음 |
| `TFRKC_focus_KCH_a2` / 후방의 문을 열다 | 14일 | `TFRKC_focus_KCH_a1` | 없음 | 없음 |
| `TFRKC_focus_KCH_a3` / 공동전선 연락실 | 21일 | `TFRKC_focus_KCH_a2` | 없음 | 없음 |
| `TFRKC_focus_KCH_m1` / 비울 수 없는 초소 | 7일 | `TFRKC_focus_KCH_start` | 없음 | 없음 |
| `TFRKC_focus_KCH_m2` / 교대되는 경계선 | 14일 | `TFRKC_focus_KCH_m1` | 없음 | 없음 |
| `TFRKC_focus_KCH_m3` / 성인 예비역의 복귀 | 21일 | `TFRKC_focus_KCH_m2` | 없음 | 없음 |
| `TFRKC_focus_KCH_p1` / 누가 군을 통제하는가 | 14일 | `TFRKC_focus_KCH_start` | 없음 | 없음 |
| `TFRKC_focus_KCH_pA` / 민간의 감사 아래 | 21일 | `TFRKC_focus_KCH_p1` | 없음 | `TFRKC_focus_KCH_pB` |
| `TFRKC_focus_KCH_pB` / 작전권을 유보하다 | 21일 | `TFRKC_focus_KCH_p1` | 없음 | `TFRKC_focus_KCH_pA` |
| `TFRKC_focus_KCH_pA2` / 헌정복원의 조건 | 14일 | `TFRKC_focus_KCH_pA` | 없음 | 없음 |
| `TFRKC_focus_KCH_pB2` / 독립지휘의 조건 | 14일 | `TFRKC_focus_KCH_pB` | 없음 | 없음 |
| `TFRKC_focus_KCH_logistics` / 두 전선의 보급표 | 14일 | `TFRKC_focus_KCH_a3`, `TFRKC_focus_KCH_m2` | 없음 | 없음 |
| `TFRKC_focus_KCH_charter` / 이긴 뒤에도 남는 질문 | 21일 | `TFRKC_focus_KCH_logistics`, `TFRKC_focus_KCH_m3` | `TFRKC_focus_KCH_pA2` 또는 `TFRKC_focus_KCH_pB2` | 없음 |

### 국가수호위원회·윤어게인 — TFRKC_focus_KYA_tree

| ID / 제목 | 기간 | 선행(AND) | 추가 선행(OR) | 배타 |
|---|---:|---|---|---|
| `TFRKC_focus_KYA_start` / 대통령의 직접 명령 | 7일 | 없음 | 없음 | 없음 |
| `TFRKC_focus_KYA_a1` / 부산의 집무실 | 7일 | `TFRKC_focus_KYA_start` | 없음 | 없음 |
| `TFRKC_focus_KYA_a2` / 경상의 교대표 | 14일 | `TFRKC_focus_KYA_a1` | 없음 | 없음 |
| `TFRKC_focus_KYA_a3` / 오늘도 열리는 시장 | 21일 | `TFRKC_focus_KYA_a2` | 없음 | 없음 |
| `TFRKC_focus_KYA_m1` / 서로 다른 제복 | 7일 | `TFRKC_focus_KYA_start` | 없음 | 없음 |
| `TFRKC_focus_KYA_m2` / 하나의 작전명령서 | 14일 | `TFRKC_focus_KYA_m1` | 없음 | 없음 |
| `TFRKC_focus_KYA_m3` / 성인 지원병의 편제 | 21일 | `TFRKC_focus_KYA_m2` | 없음 | 없음 |
| `TFRKC_focus_KYA_p1` / 위원회의 세 목소리 | 14일 | `TFRKC_focus_KYA_start` | 없음 | 없음 |
| `TFRKC_focus_KYA_pA` / 충성에도 서열이 있다 | 21일 | `TFRKC_focus_KYA_p1` | 없음 | `TFRKC_focus_KYA_pB` |
| `TFRKC_focus_KYA_pB` / 구국의 연단 | 21일 | `TFRKC_focus_KYA_p1` | 없음 | `TFRKC_focus_KYA_pA` |
| `TFRKC_focus_KYA_pA2` / 결재선의 맨 위 | 14일 | `TFRKC_focus_KYA_pA` | 없음 | 없음 |
| `TFRKC_focus_KYA_pB2` / 기도와 구호 사이 | 14일 | `TFRKC_focus_KYA_pB` | 없음 | 없음 |
| `TFRKC_focus_KYA_logistics` / 물류는 구호를 모른다 | 14일 | `TFRKC_focus_KYA_a3`, `TFRKC_focus_KYA_m2` | 없음 | 없음 |
| `TFRKC_focus_KYA_charter` / 비상은 언제 끝나는가 | 21일 | `TFRKC_focus_KYA_logistics`, `TFRKC_focus_KYA_m3` | `TFRKC_focus_KYA_pA2` 또는 `TFRKC_focus_KYA_pB2` | 없음 |

### 국가재건최고회의 — TFRKC_focus_KRC_tree

| ID / 제목 | 기간 | 선행(AND) | 추가 선행(OR) | 배타 |
|---|---:|---|---|---|
| `TFRKC_focus_KRC_start` / 장막 밖의 최고회의 | 7일 | 없음 | 없음 | 없음 |
| `TFRKC_focus_KRC_a1` / 군정청의 서식 | 7일 | `TFRKC_focus_KRC_start` | 없음 | 없음 |
| `TFRKC_focus_KRC_a2` / 기술관료를 부르다 | 14일 | `TFRKC_focus_KRC_a1` | 없음 | 없음 |
| `TFRKC_focus_KRC_a3` / 산업계와 맺는 계약 | 21일 | `TFRKC_focus_KRC_a2` | 없음 | 없음 |
| `TFRKC_focus_KRC_m1` / 기동부대 점호 | 7일 | `TFRKC_focus_KRC_start` | 없음 | 없음 |
| `TFRKC_focus_KRC_m2` / 출동 가능한 전차 | 14일 | `TFRKC_focus_KRC_m1` | 없음 | 없음 |
| `TFRKC_focus_KRC_m3` / 같은 무전망 | 21일 | `TFRKC_focus_KRC_m2` | 없음 | 없음 |
| `TFRKC_focus_KRC_p1` / 재건이라는 이름 | 14일 | `TFRKC_focus_KRC_start` | 없음 | 없음 |
| `TFRKC_focus_KRC_pA` / 남영신의 일정표 | 21일 | `TFRKC_focus_KRC_p1` | 없음 | `TFRKC_focus_KRC_pB` |
| `TFRKC_focus_KRC_pB` / 국가를 정렬하라 | 21일 | `TFRKC_focus_KRC_p1` | 없음 | `TFRKC_focus_KRC_pA` |
| `TFRKC_focus_KRC_pA2` / 민간 전문가의 자리 | 14일 | `TFRKC_focus_KRC_pA` | 없음 | 없음 |
| `TFRKC_focus_KRC_pB2` / 명령의 유효기간 | 14일 | `TFRKC_focus_KRC_pB` | 없음 | 없음 |
| `TFRKC_focus_KRC_logistics` / 정비창의 우선순위 | 14일 | `TFRKC_focus_KRC_a3`, `TFRKC_focus_KRC_m2` | 없음 | 없음 |
| `TFRKC_focus_KRC_charter` / 재건의 다음 장 | 21일 | `TFRKC_focus_KRC_logistics`, `TFRKC_focus_KRC_m3` | `TFRKC_focus_KRC_pA2` 또는 `TFRKC_focus_KRC_pB2` | 없음 |

### 청소년해방군 — TFRKC_focus_KLF_tree

| ID / 제목 | 기간 | 선행(AND) | 추가 선행(OR) | 배타 |
|---|---:|---|---|---|
| `TFRKC_focus_KLF_start` / 다음 세대에게는 | 7일 | 없음 | 없음 | 없음 |
| `TFRKC_focus_KLF_a1` / 동네마다 열린 회의 | 7일 | `TFRKC_focus_KLF_start` | 없음 | 없음 |
| `TFRKC_focus_KLF_a2` / 빈방에 놓인 식탁 | 14일 | `TFRKC_focus_KLF_a1` | 없음 | 없음 |
| `TFRKC_focus_KLF_a3` / 배움과 노동의 권리 | 21일 | `TFRKC_focus_KLF_a2` | 없음 | 없음 |
| `TFRKC_focus_KLF_m1` / 어른들이 맡을 전선 | 7일 | `TFRKC_focus_KLF_start` | 없음 | 없음 |
| `TFRKC_focus_KLF_m2` / 의용군 지휘규정 | 14일 | `TFRKC_focus_KLF_m1` | 없음 | 없음 |
| `TFRKC_focus_KLF_m3` / 돌아온 장병의 경험 | 21일 | `TFRKC_focus_KLF_m2` | 없음 | 없음 |
| `TFRKC_focus_KLF_p1` / 해방의 속도 | 14일 | `TFRKC_focus_KLF_start` | 없음 | 없음 |
| `TFRKC_focus_KLF_pA` / 합의가 남기는 길 | 21일 | `TFRKC_focus_KLF_p1` | 없음 | `TFRKC_focus_KLF_pB` |
| `TFRKC_focus_KLF_pB` / 지금 바꾸는 삶 | 21일 | `TFRKC_focus_KLF_p1` | 없음 | `TFRKC_focus_KLF_pA` |
| `TFRKC_focus_KLF_pA2` / 거부할 수 있는 권리 | 14일 | `TFRKC_focus_KLF_pA` | 없음 | 없음 |
| `TFRKC_focus_KLF_pB2` / 개혁의 현장위원회 | 14일 | `TFRKC_focus_KLF_pB` | 없음 | 없음 |
| `TFRKC_focus_KLF_logistics` / 급식소와 보급소 | 14일 | `TFRKC_focus_KLF_a3`, `TFRKC_focus_KLF_m2` | 없음 | 없음 |
| `TFRKC_focus_KLF_charter` / 넘겨주지 않을 것들 | 21일 | `TFRKC_focus_KLF_logistics`, `TFRKC_focus_KLF_m3` | `TFRKC_focus_KLF_pA2` 또는 `TFRKC_focus_KLF_pB2` | 없음 |

### 전국노동자평의회 — TFRKC_focus_KWC_tree

| ID / 제목 | 기간 | 선행(AND) | 추가 선행(OR) | 배타 |
|---|---:|---|---|---|
| `TFRKC_focus_KWC_start` / 교대종은 울려야 한다 | 7일 | 없음 | 없음 | 없음 |
| `TFRKC_focus_KWC_a1` / 작업장 사이의 전화 | 7일 | `TFRKC_focus_KWC_start` | 없음 | 없음 |
| `TFRKC_focus_KWC_a2` / 전력과 식량의 순서 | 14일 | `TFRKC_focus_KWC_a1` | 없음 | 없음 |
| `TFRKC_focus_KWC_a3` / 임금 대신 배급만 남지 않게 | 21일 | `TFRKC_focus_KWC_a2` | 없음 | 없음 |
| `TFRKC_focus_KWC_m1` / 산업지대의 방위대 | 7일 | `TFRKC_focus_KWC_start` | 없음 | 없음 |
| `TFRKC_focus_KWC_m2` / 서로의 담장을 지키다 | 14일 | `TFRKC_focus_KWC_m1` | 없음 | 없음 |
| `TFRKC_focus_KWC_m3` / 성인 예비역의 작업복 | 21일 | `TFRKC_focus_KWC_m2` | 없음 | 없음 |
| `TFRKC_focus_KWC_p1` / 누가 할당량을 정하는가 | 14일 | `TFRKC_focus_KWC_start` | 없음 | 없음 |
| `TFRKC_focus_KWC_pA` / 현장의 거부권 | 21일 | `TFRKC_focus_KWC_p1` | 없음 | `TFRKC_focus_KWC_pB` |
| `TFRKC_focus_KWC_pB` / 전시 생산배정국 | 21일 | `TFRKC_focus_KWC_p1` | 없음 | `TFRKC_focus_KWC_pA` |
| `TFRKC_focus_KWC_pA2` / 지원에도 서명이 필요하다 | 14일 | `TFRKC_focus_KWC_pA` | 없음 | 없음 |
| `TFRKC_focus_KWC_pB2` / 바깥과 협상할 대표 | 14일 | `TFRKC_focus_KWC_pB` | 없음 | 없음 |
| `TFRKC_focus_KWC_logistics` / 기차 시간과 교대 시간 | 14일 | `TFRKC_focus_KWC_a3`, `TFRKC_focus_KWC_m2` | 없음 | 없음 |
| `TFRKC_focus_KWC_charter` / 전쟁 뒤의 작업장 | 21일 | `TFRKC_focus_KWC_logistics`, `TFRKC_focus_KWC_m3` | `TFRKC_focus_KWC_pA2` 또는 `TFRKC_focus_KWC_pB2` | 없음 |

### 민족정화전선 — TFRKC_focus_KSF_tree

| ID / 제목 | 기간 | 선행(AND) | 추가 선행(OR) | 배타 |
|---|---:|---|---|---|
| `TFRKC_focus_KSF_start` / 완장을 하나로 | 7일 | 없음 | 없음 | 없음 |
| `TFRKC_focus_KSF_a1` / 검문소의 장부 | 7일 | `TFRKC_focus_KSF_start` | 없음 | 없음 |
| `TFRKC_focus_KSF_a2` / 멎어 가는 작업대 | 14일 | `TFRKC_focus_KSF_a1` | 없음 | 없음 |
| `TFRKC_focus_KSF_a3` / 고립된 창구 | 21일 | `TFRKC_focus_KSF_a2` | 없음 | 없음 |
| `TFRKC_focus_KSF_m1` / 무장조직의 서열 | 7일 | `TFRKC_focus_KSF_start` | 없음 | 없음 |
| `TFRKC_focus_KSF_m2` / 단일한 완장 | 14일 | `TFRKC_focus_KSF_m1` | 없음 | 없음 |
| `TFRKC_focus_KSF_m3` / 부서진 명령의 복창 | 21일 | `TFRKC_focus_KSF_m2` | 없음 | 없음 |
| `TFRKC_focus_KSF_p1` / 구원의 경계선 | 14일 | `TFRKC_focus_KSF_start` | 없음 | 없음 |
| `TFRKC_focus_KSF_pA` / 좁아지는 우리 | 21일 | `TFRKC_focus_KSF_p1` | 없음 | `TFRKC_focus_KSF_pB` |
| `TFRKC_focus_KSF_pB` / 필요한 사람들의 예외 | 21일 | `TFRKC_focus_KSF_p1` | 없음 | `TFRKC_focus_KSF_pA` |
| `TFRKC_focus_KSF_pA2` / 방송이 끝난 거리 | 14일 | `TFRKC_focus_KSF_pA` | 없음 | 없음 |
| `TFRKC_focus_KSF_pB2` / 장부에 남겨 둔 이름 | 14일 | `TFRKC_focus_KSF_pB` | 없음 | 없음 |
| `TFRKC_focus_KSF_logistics` / 통제선 너머의 납품서 | 14일 | `TFRKC_focus_KSF_a3`, `TFRKC_focus_KSF_m2` | 없음 | 없음 |
| `TFRKC_focus_KSF_charter` / 구원 뒤에 남는 국가 | 21일 | `TFRKC_focus_KSF_logistics`, `TFRKC_focus_KSF_m3` | `TFRKC_focus_KSF_pA2` 또는 `TFRKC_focus_KSF_pB2` | 없음 |

### 해군 중립사령부 — TFRKC_focus_KNM_tree

| ID / 제목 | 기간 | 선행(AND) | 추가 선행(OR) | 배타 |
|---|---:|---|---|---|
| `TFRKC_focus_KNM_rescue` / 구조 신호에 응답하라 | 7일 | 없음 | 없음 | 없음 |
| `TFRKC_focus_KNM_shelter` / 섬의 임시 거처 | 14일 | `TFRKC_focus_KNM_rescue` | 없음 | 없음 |
| `TFRKC_focus_KNM_maintenance` / 정박 중의 정비 | 14일 | `TFRKC_focus_KNM_rescue` | 없음 | 없음 |
| `TFRKC_focus_KNM_ledger` / 돌려줄 함대의 장부 | 21일 | `TFRKC_focus_KNM_shelter`, `TFRKC_focus_KNM_maintenance` | 없음 | 없음 |

### 대한인민해방군 — TFRKC_focus_KPL_tree

| ID / 제목 | 기간 | 선행(AND) | 추가 선행(OR) | 배타 |
|---|---:|---|---|---|
| `TFRKC_focus_KPL_contact` / 서로 다른 명령서 | 7일 | 없음 | 없음 | 없음 |
| `TFRKC_focus_KPL_liaison` / 공동지휘 연락망 | 14일 | `TFRKC_focus_KPL_contact` | 없음 | 없음 |
| `TFRKC_focus_KPL_civilian` / 민간 수송과의 분리 | 14일 | `TFRKC_focus_KPL_contact` | 없음 | 없음 |
| `TFRKC_focus_KPL_settlement` / 승리 뒤의 협의서 | 21일 | `TFRKC_focus_KPL_liaison`, `TFRKC_focus_KPL_civilian` | 없음 | 없음 |

### 통일 이후 확장 기반 — TFRKC_focus_POST_tree

| ID / 제목 | 기간 | 선행(AND) | 추가 선행(OR) | 배타 |
|---|---:|---|---|---|
| `TFRKC_focus_POST_inventory` / 남겨진 국가의 목록 | 21일 | 없음 | 없음 | 없음 |
| `TFRKC_focus_POST_civilian` / 평시로 돌아가는 창구 | 35일 | `TFRKC_focus_POST_inventory` | 없음 | 없음 |

## 국민정신·외교·툴팁 ID

| 국민정신 ID | 명칭 | 수정치 |
|---|---|---|
| `TFRKC_focus_gov_supply` | 수도의 배급망 | supply_consumption_factor=-0.04 |
| `TFRKC_focus_gov_repair` | 잔류 정비인력 | production_factory_efficiency_gain_factor=0.04, industrial_capacity_factory=0.02 |
| `TFRKC_focus_gov_civil` | 기록되는 비상권한 | stability_factor=0.03, political_power_gain=-0.05 |
| `TFRKC_focus_gov_emergency` | 한시적 긴급예산 | industrial_capacity_factory=0.04, stability_factor=-0.03 |
| `TFRKC_focus_ch_front` | 교대되는 경계선 | army_org_factor=-0.06, supply_consumption_factor=0.06 |
| `TFRKC_focus_ch_civil` | 민간 연락위원회 | stability_factor=0.03, planning_speed=-0.03 |
| `TFRKC_focus_ch_oversight` | 감사받는 지휘권 | political_power_gain=0.1, planning_speed=-0.05 |
| `TFRKC_focus_ch_autonomy` | 작전권 유보 | planning_speed=0.08, stability_factor=-0.04 |
| `TFRKC_focus_ya_command` | 조율되는 충성 | army_org_factor=-0.07, army_morale_factor=-0.04 |
| `TFRKC_focus_ya_factory` | 경상 공업의 교대표 | industrial_capacity_factory=0.04, production_factory_efficiency_gain_factor=0.03 |
| `TFRKC_focus_ya_cadre` | 충성의 서열 | army_morale_factor=0.04, political_power_gain=0.1, stability_factor=-0.03 |
| `TFRKC_focus_ya_crusade` | 구국 연단 | war_support_factor=0.06, political_power_gain=-0.12, industrial_capacity_factory=-0.02 |
| `TFRKC_focus_rc_fuel` | 출동 가능한 전차 | fuel_gain_factor=-0.12, supply_consumption_factor=0.08 |
| `TFRKC_focus_rc_tech` | 기술관료 실무반 | production_factory_efficiency_gain_factor=0.05, political_power_gain=-0.05 |
| `TFRKC_focus_rc_nam` | 재건의 일정표 | industrial_capacity_factory=0.04, stability_factor=0.02 |
| `TFRKC_focus_rc_hard` | 명령으로 세운 질서 | army_org_factor=0.04, industrial_capacity_factory=-0.04, stability_factor=-0.04 |
| `TFRKC_focus_lf_command` | 성인 의용군 지휘부 | army_org_factor=-0.08, training_time_army_factor=0.08 |
| `TFRKC_focus_lf_housing` | 빈방과 식탁 | stability_factor=0.04, industrial_capacity_factory=-0.02 |
| `TFRKC_focus_lf_reform` | 합의하는 해방 | political_power_gain=0.12, planning_speed=-0.04 |
| `TFRKC_focus_lf_radical` | 지금 바꾸는 삶 | war_support_factor=0.04, industrial_capacity_factory=0.03, stability_factor=-0.04 |
| `TFRKC_focus_wc_command` | 연결된 방위평의회 | army_core_defence_factor=0.1, army_org_factor=-0.11 |
| `TFRKC_focus_wc_grid` | 꺼지지 않는 교대등 | industrial_capacity_factory=0.05, production_factory_efficiency_gain_factor=0.03 |
| `TFRKC_focus_wc_local` | 현장의 거부권 | stability_factor=0.04, production_factory_efficiency_gain_factor=-0.03 |
| `TFRKC_focus_wc_plan` | 전시 생산배정국 | industrial_capacity_factory=0.06, stability_factor=-0.04, political_power_gain=-0.05 |
| `TFRKC_focus_sf_command` | 단일한 완장 | army_org_factor=-0.12, political_power_gain=-0.15 |
| `TFRKC_focus_sf_control` | 검문소의 장부 | war_support_factor=0.03, industrial_capacity_factory=-0.05, stability_factor=-0.03 |
| `TFRKC_focus_sf_purge` | 좁아지는 우리 | army_attack_factor=0.04, recruitable_population_factor=-0.08, industrial_capacity_factory=-0.07, stability_factor=-0.05 |
| `TFRKC_focus_sf_pragmatic` | 필요한 사람들의 예외 | production_factory_efficiency_gain_factor=0.03, war_support_factor=-0.04, political_power_gain=-0.1 |
| `TFRKC_focus_navy_rescue` | 구조 우선의 항로 | naval_accidents_chance=-0.1 |
| `TFRKC_focus_pl_liaison` | 공동지휘 연락망 | army_org_factor=-0.05, supply_consumption_factor=0.05 |

국민정신 제목/설명 키도 각각 ID / ID_desc입니다. 외교 의견 수정치는 `TFRKC_focus_exclusion_opinion`(-20), 신규 디시전은 없습니다.

툴팁 키:

- `TFRKC_focus_administration_tt`
- `TFRKC_focus_aid_tt`
- `TFRKC_focus_pdto_tt`
- `TFRKC_focus_nato_tt`
- `TFRKC_focus_joint_tt`
- `TFRKC_focus_constitutional_tt`
- `TFRKC_focus_intervention_tt`
- `TFRKC_focus_workers_settlement_tt`
- `TFRKC_focus_navy_tt`
- `TFRKC_focus_postwar_tt`
- `TFRKC_focus_extension_tt`

## 그림 출처

별도 생성 이미지는 사용하지 않았습니다. 모든 중점 아이콘 8종과 국민정신 그림 4종은 실제 설치 TFRKP 정의와 PNG 파일을 확인해 의존성 이름으로 참조합니다. 자산을 복사하거나 Workshop 그림을 수정하지 않습니다. manifest에 각 원본 정의 파일과 실제 textureSource 경로를 보관했습니다.

- `GFX_KOR_lee_army_route_common_focus_1` → `gfx/interface/goals/KOR/focus_GFX_KOR_lee_army_route_common_focus_1.png`
- `GFX_KOR_lee_army_route_common_focus_2` → `gfx/interface/goals/KOR/focus_GFX_KOR_lee_army_route_common_focus_2.png`
- `GFX_KOR_lee_army_route_promise_democracy` → `gfx/interface/goals/KOR/focus_GFX_KOR_lee_army_route_promise_democracy.png`
- `GFX_KOR_strengthening_international_cooperation` → `gfx/interface/goals/KOR/focus_GFX_KOR_strengthening_international_cooperation.png`
- `GFX_KOR_support_for_mask` → `gfx/interface/goals/KOR/focus_GFX_KOR_support_for_mask.png`
- `GFX_KOR_yoon_constitution_control` → `gfx/interface/goals/KOR/focus_GFX_KOR_yoon_constitution_control.png`
- `GFX_KOR_yoon_yoons_think` → `gfx/interface/goals/KOR/focus_GFX_KOR_yoon_yoons_think.png`
- `GFX_KOR_domestic_production` → `gfx/interface/goals/KOR/focus_GFX_KOR_domestic_production.png`
- `GFX_idea_KOR_army_noman_idea` → `gfx/interface/ideas/KOR/idea_KOR_army_noman_idea.png`
- `GFX_idea_KOR_japan_assistance_idea` → `gfx/interface/ideas/KOR/idea_KOR_japan_assistance_idea.png`
- `GFX_idea_KOR_after_bubble_defeat_idea` → `gfx/interface/ideas/KOR/idea_KOR_after_bubble_defeat_idea.png`
- `GFX_idea_KOR_army_great_nation_idea` → `gfx/interface/ideas/KOR/idea_KOR_army_great_nation_idea.png`

## 검증·제한

`node tools/build-focus.cjs` → `node tools/validate-focus.cjs` → `& ./tools/render-focus.ps1`로 재검사할 수 있습니다. 빌더는 전용 파일만 갱신하며 소유하지 않은 기존 파일을 덮어쓰려 하면 중단합니다. 원본 파일에 신규 접두사 중복이 있으면 쓰기 전에 중단합니다.

정적 검사 14개: 구문/배포 일치, 기존 파일 보존, 유효 ID 중복, 선행 누락/순환, 양쪽 배타 경로의 최종 도달, 좌표/다른 아이콘을 가로지르는 연결선, 종료·항복·영토 상실 가드, 금지된 개입/합병/건물/병력 생성 부재, 효과·아이디어·수정치 참조, 실제 그림 파일, UTF-8 BOM/키/인용/색상, 태그 할당/트리 우선순위/일일 멱등성, 약점 조건부 교체/전후 정리, AI 초기 선택 가중치입니다. 결과는 validation-focus.json에 있습니다.

단순 구문 파서가 읽지 못한 원본/바닐라 6개 파일은 보고서 inheritedParserLimitations에 따로 기록했습니다. 그 파일에는 신규 TFRKC_focus_ 식별자가 없음을 별도로 확인했으며 이를 신규 파일의 구문 통과와 혼동하지 않습니다. 원본 전체의 엔진 정상성을 보증하는 검사도 아닙니다.

실행 시도: HOI4를 현재 사용자의 TFR 구성 모드 목록 그대로 실행했습니다. 사용자 확인에 따라 활성 추가 2개도 TFR 구성으로 보며 임의로 해제하지 않았습니다. 화면 도구가 게임의 접근성 상태를 읽지 못하고 전면 전환에 시간 초과가 발생해 실제 중점 화면을 확인하지 못했습니다. 16:10~16:12 로딩 로그는 15,193개 프로빈스 및 역사 실행 단계까지 기록했고, 당시 TFRKC_focus_ 관련 오류 행은 없었습니다. 이것은 초기 로딩 관찰이며 게임 내 전환/보상/AI 검증은 아닙니다. 이후 추가한 외교 의견 비용까지 포함한 최종 파일은 정적 검증만 완료했습니다. 현재 error.log에는 여러 원본 항목의 오류가 있어 전체 무오류를 주장하지 않습니다.

최소 게임 수동 검증: 새 비철인 게임에서 기존 개발 규칙과 tfrkc.90으로 분할/개전 진입 → 한 일일 틱 후 각 태그의 전용 트리 확인 → 7일 수습 중점과 양쪽 배타 노선, 국가별 약점 교체, 정부 행정 디시전 병행 확인 → 해군·개입군은 실제 해당 단계에서만 확인 → 기존 통일 효과 성립 후 다음 일일 틱에 전후 2중점 및 전시 국민정신 제거 확인. 날짜 계산은 기존 연표 담당의 테스트를 따르며 개발 우회로 달력 검증을 대체하지 않습니다.
