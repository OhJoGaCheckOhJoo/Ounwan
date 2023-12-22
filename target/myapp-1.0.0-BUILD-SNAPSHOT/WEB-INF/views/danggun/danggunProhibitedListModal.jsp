<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <div id="prohibitedListModal" class="prohibited-list-modal">
        <div id="modalContent">
          <div id="modalBody">
            <span id="closeBtn" onclick="closeProhibitedListModal()">&times;</span>
            <div>
                <div class="title-container">
                    <div class="ounwan">
                        OUNWAN
                    </div>
                    <div class="prohibited-list-title">
                        거래 금지 품목
                    </div>
                </div>
                <hr>
                <div class="prohibited-list-reason-container">
                    <div class="reason-explain top">
                        거래금지품목은 이용약관 및 현행 법률에 따라 즉시 삭제 및 계정 차단이 될 수 있으므로 참고하셔서 이용 부탁 드립니다.
                    </div>
                    <div class="reason-content-container">
                        <div class="reason-content-list">
                            <div class="reason-content">
                                <div class="reason-name">개인정보</div> 
                                <div class="reason-content">개인정보를 사고파는 행위와 면허증, 허가증, 등록증 등을 위, 변조하는 행위는 형법에 따라 처벌받을 수 있습니다.</div>
                            </div>
                        </div>
                        <div class="reason-content-list">
                            <div class="reason-content">
                                <div class="reason-name">온라인 개인 계정</div> 
                                <div class="reason-content">개인 계정 및 인증번호를 통해 각종 피해가 발생되고 있어 OUNWAN 운영정책에 따라 제재 됩니다.</div>
                            </div>
                        </div>
                        <div class="reason-content-list">
                            <div class="reason-content">
                                <div class="reason-name">사행성</div> 
                                <div class="reason-content">불법 도박 및 사행성 상품은 OUNWAN 운영정책에 따라 제재 됩니다.</div>
                            </div>
                        </div>
                        <div class="reason-content-list">
                            <div class="reason-content">
                                <div class="reason-name">성인용품</div> 
                                <div class="reason-content">방송통신심의위원회의 정보통신에 관한 심의 규정에 따라 음란물로 구분되는 상품은 인터넷으로 유통이 불가하며, 성인 전용 상품 판매 시 운영정책에 따라 제재 됩니다.</div>
                            </div>
                        </div>
                        
                        <div class="reason-content-list">
                            <div class="reason-content">
                                <div class="reason-name">청소년유해상품</div> 
                                <div class="reason-content">청소년유해 매체물/약품/물건은 청소년 보호법에 따라 제재 됩니다.</div>
                            </div>
                        </div>
                        <div class="reason-content-list">
                            <div class="reason-content">
                                <div class="reason-name">반려동물/야생동물</div> 
                                <div class="reason-content">반려동물 및 야생동물은 OUNWAN 운영정책에 따라 제재 됩니다.</div>
                            </div>
                        </div>
                        <div class="reason-content-list">
                            <div class="reason-content">
                                <div class="reason-name">비인도적 거래(장난글 포함)</div> 
                                <div class="reason-content">개인정보를 사고파는 행위와 면허증, 허가증, 등록증 등을 위, 변조하는 행위는 형법에 따라 처벌받을 수 있습니다.</div>
                            </div>
                        </div>
                        <div class="reason-content-list">
                            <div class="reason-content">
                                <div class="reason-name">개인정보</div> 
                                <div class="reason-content">타인의 명예를 훼손하는 사람거래 관련 게시글은 아동복지법 및 정신통신망법(명예훼손)에 따라 제재 됩니다.</div>
                            </div>
                        </div>
                        <div class="reason-content-list">
                            <div class="reason-content">
                                <div class="reason-name">주류</div> 
                                <div class="reason-content">주세법에 따라 주류소매업 및 의제주류판매업 면허를 받은 자는 허가된 장소에서만 주류를 판매하여야 하고, 통신판매는 할 수 없도록 규정되어 있습니다.</div>
                            </div>
                        </div>
                        <div class="reason-content-list">
                            <div class="reason-content">
                                <div class="reason-name">담배(전자담배용품) </div> 
                                <div class="reason-content">담배사업법에 따라 담배의 온라인 판매는 금지되어 있으며, 담뱃잎을 사용하지 않았다 하더라도 그 유사한 형태의 끽연용 제품은 담배와 동일하게 판매를 규제하고 있습니다.</div>
                            </div>
                        </div>
                        <div class="reason-content-list">
                            <div class="reason-content">
                                <div class="reason-name">군용품/군복류</div> 
                                <div class="reason-content">경찰제복 및 경찰장비의 규제에 관한 법률에 따라 제조 및 판매가 금지됩니다.</div>
                            </div>
                        </div>
                        <div class="reason-content-list">
                            <div class="reason-content">
                                <div class="reason-name">신고증(허가증) 제출 필요 상품</div> 
                                <div class="reason-content">신고증(허가증)을 제출하지 않고 판매 시 OUNWAN 운영정책에 따라 제재됩니다.</div>
                            </div>
                        </div>
                        <div class="reason-content-list">
                            <div class="reason-content">
                                <div class="reason-name">군용품/군복류</div> 
                                <div class="reason-content">경찰제복 및 경찰장비의 규제에 관한 법률에 따라 제조 및 판매가 금지됩니다.</div>
                            </div>
                        </div>
                        <div class="reason-content-list">
                            <div class="reason-content">
                                <div class="reason-name">의약품</div> 
                                <div class="reason-content">모든 의약품(동물용 의약품 포함)은 약사법에 의거 약국 개설자(해당 약국에 근무하는 약사 또는 한약사 포함)만이 판매 가능하며, 약국 개설자의 경우에도 지방자치단체장의 승인을 얻은 경우를 제외하고는 인터넷을 통한 판매가 불가합니다.</div>
                            </div>
                        </div>
                        <div class="reason-content-list">
                            <div class="reason-content">
                                <div class="reason-name">특정 의료기기</div> 
                                <div class="reason-content">유축기, MD크림, 코로나 자가진단키트, 인슐린주사기, 메디폼, 듀오덤은 '의료기기 판매 허가증' 소지 여부와 관계 없이 거래를 금지하고 있습니다. </div>
                            </div>
                        </div>
                        <div class="reason-content-list">
                            <div class="reason-content">
                                <div class="reason-name">콘택트렌즈/시력보정용안경</div> 
                                <div class="reason-content">의료기사 등에 관한 법률 제 12조 5항에 의거 온라인 판매가 불가합니다.</div>
                            </div>
                        </div>
                        <div class="reason-content-list">
                            <div class="reason-content">
                                <div class="reason-name">불법시술</div> 
                                <div class="reason-content">현행 의료법령에 따라 의료인만 반영구화장과 같은 문신 시술을 할 수 있고 가정용 의료기기도 피부관리실에서 사용 불가합니다.</div>
                            </div>
                        </div>
                        <div class="reason-content-list">
                            <div class="reason-content">
                                <div class="reason-name">상품권</div> 
                                <div class="reason-content">재난기본소득은 부정한 방법으로 지급받은 경우 지역 조례에 따라 환수 조치 될 수 있으며, 선불카드/지역화폐를 거래하는 경우 접근 매체를 넘겨주거나 받는 행위로 판매자, 구매자 모두 처벌 받을 수 있습니다. (전자금융거래법 제49조 4항 1호)</div>
                            </div>
                        </div>
                        <div class="reason-content-list">
                            <div class="reason-content">
                                <div class="reason-name">비트코인/가상화폐/암호화폐</div> 
                                <div class="reason-content">암호화폐를 판매할 경우 OUNWAN 운영 정책에 따라 제재됩니다.</div>
                            </div>
                        </div>
                        <div class="reason-content-list">
                            <div class="reason-content">
                                <div class="reason-name">불법상품</div> 
                                <div class="reason-content">부정경쟁방지 및 영업비밀보호에 관한 법률에 따라 판매가 불가합니다.</div>
                            </div>
                        </div>
                        <div class="reason-content-list">
                            <div class="reason-content">
                                <div class="reason-name">국가로부터 수여 받은 훈장 및 포장</div> 
                                <div class="reason-content">상훈법 제 40조에 따라 훈장 및 포장은 매매가 금지됩니다. (상훈법 제 40조. 정부와의 계약에 의하지 아니하고 훈장 또는 포장을 제작하거나 매매한자는 1년 이하의 징역 또는 1천만원 이하의 벌금에 처한다.)</div>
                            </div>
                        </div>
                        <div class="reason-content-list">
                            <div class="reason-content">
                                <div class="reason-name">안전인증표시 없는 안전인증대상제품</div> 
                                <div class="reason-content">안전 인증 표시 없는 안전 인증 대상 제품은 전기용품 및 생활용품 안전관리법상 판매 금지됩니다.</div>
                            </div>
                        </div>
                        <div class="reason-content-list">
                            <div class="reason-content">
                                <div class="reason-name">리콜 대상 상품</div> 
                                <div class="reason-content">리콜 대상 상품은 소비자기본법에 따라 제조 및 판매가 금지됩니다.</div>
                            </div>
                        </div>
                        <div class="reason-content-list">
                            <div class="reason-content">
                                <div class="reason-name">화장품 소분판매</div> 
                                <div class="reason-content">화장품 원 상품을 판매의 목적으로 의도적으로 소분하여 판매하는 것은 화장품법에 따라 판매가 불가합니다.</div>
                            </div>
                        </div>
                        <div class="reason-content-list">
                            <div class="reason-content">
                                <div class="reason-name">암표</div> 
                                <div class="reason-content">암표 매매란 흥행장, 경기장, 역, 나루터, 정류장, 그 밖에 정하여진 요금을 받고 입장시키거나 승차 또는 승선 시키는 곳에서 웃돈을 받고 입장권, 승차권 또는 승선권을 다른 사람에게 되파는 것을 뜻합니다.</div>
                            </div>
                        </div>
                        <div class="reason-content-list">
                            <div class="reason-content">
                                <div class="reason-name">기타</div> 
                                <div class="reason-content">폰테크 관련 상품, 상품 상태를 알 수 없는 랜덤박스, 쿠팡 나중결제 한도 판매, 유통기한 경과 상품(가공식품, 화장품, 생활용품 등 모두 포함), 개봉된 식품, 목적 불분명한 알바, 영리목적으로 제3자에게 자료 및 정보 제공 등 거래 시 OUNWAN 운영정책에 따라 제재 됩니다.</div>
                            </div>
                        </div>
                    </div>
                    <div class="reason-explain bottom">
                        위 거래금지품목 이외  전자상거래 또는 통신판매로 유통/판매가 금지되어 있거나, 사회통념상 매매에 부적합하다고 '회사'가 판단하는 경우 제재 됩니다.
                    </div>
                </div>
            </div>
          </div>
        </div>

    </div>

    <div id="ProhibitedModalOverlay" class="modal-overlay" onclick="closeprohibitedListModal()"></div>