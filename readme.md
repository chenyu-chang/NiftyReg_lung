# Feature-based NiftyReg

By utilizing lung masks, airway masks, and vesselness masks, we apply distance transforms to the lungs and airways to create gradient-enhanced mask boundaries. Ultimately, we employ the distance-transformed lung mask, the distance-transformed airway mask, and the vesselness mask for the purpose of registration.

# Folder Structure
- data
  - case1
    - 20110224
      - dicom
      - mask
    - 20110526
      - dicom
      - mask
  - case2
    - 20110525
      - dicom
      - mask
    - 20110926
      - dicom
      - mask

##  Flow Chart:

```mermaid
graph LR

A[lung segmentation tool] -- "lungs.mat" --> B[main_feature.m]
A[lung segmentation tool] -- "lung_surface.mat" --> B[main_feature.m]
A[lung segmentation tool] -- "airways.mat" --> B[main_feature.m]
A[lung segmentation tool] -- "vessel.mat" --> B[main_feature.m]
B --> C[main_niftyreg.m]
```
## Feature Demo

 1. masked lungs mask distance tranceform

![masked lung mask distance tranceform](https://lh3.googleusercontent.com/pw/ADCreHfpgAAylFYoi0_1tSCcG5NsRQo4IFGnt5fnS0Ri03bj46U7CV3LRwnCYJBf7SEZ0BDlWE3bnYfnCtmNo0Ayj8jtOI9FVUxWvkrXpFPpNvWm2YaPWIptxij96HUCJ7EgvgDYqJeNPGpuTNHuVcsL55EPO3QGjTVtAa_FO3fUpW0gRarYCvOL7RctuIFHXaA1aQXZtatsx8cRPXzRYz7MaZ6WtC_D8YS1DDl0IrQuUQzsATM68m_vnDVmIeZsWwEuO3XndFeyFX07g7hAOegtXwVU7NxCP81LFYtGubSwbnP36IeZpGE2W3uj-N5qwMBo9u0KPsgF0-i4cuMr5OYJfU-6Bl1pixGUUB84gITJ6o5TBPeEsKHmgRLNm_cR8Pb0Gk2CyVixGyfmjTrJIicybBbc3hnzQOBcn9EeBSw6fd8l8_A7Q1BXMs2gtO7g0rnV3xhT7PaPRvDHUNCR4z8n5p5zmpR004F26BflS6WsaQU8rSQr7Wv0axTZ53lGzQzbtsBNT9Sd1N82ctpflXVgdDUUxGuheoCucHS3kAJ20lAj90i7p_FuvfBmuYtPfnoecdg5lJWBndMyksKzUMojlXChDwuMpitDeh3E6Qh6zgSw2HvrFxL8IgBdUBaofeOLFhegkgnkfqueOpoAQhAT1VqWgbsKb1YMijEs8zkLSw2rmfxmRVlcrxti--_AaXX7bTsoQzivTdblaWz_eOoXP2RejOVjBmhv9yg6-5MJFEb4qjZiy0ALj2UsFgmv7mX4WCbL1NNmW95Vj5k_Gh1YwlT1C-EWdH0_XQhE7feaDUFqOTuJ46UUOYR-s4cKe-lxxsz4pKtS2YHB26T1n2dyBsDWE7EVSMvCMt0jBaD804JoZu1dr-Z_Gg8ToEXCDexS4SUJRUxy-RJwkSUUDbIOzFpHjv7MIrJyXt_C1wf8RKUAwk5oUbPO-yCghFMuXfs=w503-h454-s-no-gm?authuser=0)

2. masked airways mask distance tranceform

![enter image description here](https://lh3.googleusercontent.com/pw/ADCreHd6xeo0mi9Endwm6Ifqf2__qR5tE42y4ghB3ikncnza3voyxfmSpo6PMYOQFAgEDqj5BgvbkA8-spvulPKeJtDrfdyiyBBroJIkaMgxukkew1eVlD8BPnh02f-O59Km5J0qMCY2EmGNCaX4LLuS69I9OKpwLj8acnkPF6BbJ0dYPLQMUmdjFzrxFpCcAGVHMc_niUyScLND9MIYPF2JODBErGyp9wcuFbXODLsT28_ldXsPp2j_tZQ6XDaiYaZsru1LXjXmh8u5PHtHQmt2Nkabc5hQQjCsQCjbLFBkQSSLiTztn22tPt3rIzES1qIJz4PBPhpdcqw6g9TrjWQV48M1OLVvBDm-4sYQ_zcoe5TLTPqp9Em2faFLrtTq7GU6LPjieTqdoheQwXbdY5pnreGh7bD9d3y1YRcSIc54n8UDwFtq7QhXx9vacw0w1byEzQZMOOATHQ_Gz8d8xJgFPZI9S-yhYWMZCVAi2PfAUjnUldSIWmSjoGLBWB92ABjsfe9bpcC7vTU0irgBF4zMUWUC_4fwG3x3Lm_BOSADPh6X0EtzwK7vyUlvGEBOSduaL0V6NvF9paHAxyw8O3yI9zBbEa431T8CEMX32LLhi-foVo53KeuaFpEPl7Q29RmiQfEgxlSIBN-Fu-ZJxiaGfEVNb2E2LKPouYAxzfrFrKoVTpfiF5WK6yZn1eukwWgSvy-grk3egAIQVr5nY3fD0CwrbtzLSg3DFQdOKB1kZHKVoms8yNUn3czrHPJVKCdgj4Fwr5xqwZqh6xP7dkBlcnYWpyd4Cow7bSj1QqB_WOYRDimn_8JAJBQCPwnCDo-3c4STcVdT56xpOrmBiyt3fFszDktdS5UR8G3ZyCx2nhKPxiwDhGhDrIWol_NjGY8XpPNSvZX21QCPfqHr1sDpVLoYQenWiA_pVoAnF5yOQrDUJbc7YImr9oJIJx0lh1A=w503-h454-s-no-gm?authuser=0)

3. Total 4D Feature

![enter image description here](https://lh3.googleusercontent.com/pw/ADCreHcptkELJgG40dtP2BoowdxLU-O94GNUjum9gUE-lp20k5tApApDfeWJBSFDalUsWNtCCS0VKPDh2pa0bwT25-h5-Z9npkuhRFyGWNKSEBSs0oK8cZLSvfmnWEtsvhSWmC09Sh1CDXD957DZ0skfJmESFn7KihSm6s48J7XK2gYhc3NmfCqF8UHqSOlFF1y4qt8gMeZSjEi8f_v2JVFkiZ8bCdMAryyG2IAHLTrSVSX9swxe-5lNwwNX6NDe03q2XYZ7_P1AKOd-m_XQqOdHlaVXkLp5otyO2w5KKpmPukjx0iGMo0BGjPK5GR8wY0SN-Thnkn8VtYTnglH629wJEjB5BxgJ-US_NvAmlVV0AMvRJmWd7kLg7sDqo-zjhRf7dvLSodsgKyR8A78tUUxWKRmrpBJoZGw9Nbsica2-ZxnWmJ3rugUP68rTcPgeaEo1xxy0a-91YX95QwkK7U1CKCh4LUseki9aG4OFLbwWWsYAWSBZHUwzLRk5Rgdugp5ZjUNQsrA8NbhiqiZYHhyUfWHnK4LeMlCgFJMPSYxE2qqgpaOYrDz-qxs-_26RIxM4peI0fmbvO3DFe0eN2AyLQuGgQtDSSKfuYKquhROHSvi3ygKD6KnU7kkPa6q0mnL_pBfZrQStswRTHXFtm5RkJXtbUeKMfB8hDOdOiHFkDXDqOhWqCfgxRi1zmeQ7Z8X4G24zDNXlctSBmU4qxSsgZpzJhW-eBogf8flv3hpddhsNPYirHONsWHqHSVPerk1Az-jEj0ijdpGewUaUoNhHOY4pxq8q7GBepFvzMgh4ThaQwGa4nJXmxHxkKSuQ1KXy0aU5CKPIHGKphGqY79jy8mXd4zXm57TDbUjf39jXaxAnRXAa9o9CYwTGL5kqWda2uPx-VvN8pyzJUzdL5IRgnPorNJ_DsjyDiOJ-VrwBAqqumciGwPAFGac8uSh-tGc=w503-h454-s-no-gm?authuser=0)

## Reference
  - https://iopscience.iop.org/article/10.1088/1361-6560/ac1b1d